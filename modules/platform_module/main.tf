# Resource group.
resource "azurerm_resource_group" "group" {
  count = var.create_rg == true ? 1 : 0

  location = "eastus"
  name     = "${local.common_name}_rg"

  tags = merge({ Name = "${local.common_name}_rg" }, local.tags)
}

# Virtual network module.
module "network" {
  source     = "./network"
  depends_on = [azurerm_resource_group.group]

  location     = "eastus"
  project_tags = local.tags
  rg_name      = local.recource_group_name
  vnet_address = ["192.168.0.0/22"]
  vnet_name    = "${local.common_name}_vnet"
  subnet = {
    public = {
      name    = "${local.common_name}_vnet_public"
      address = ["192.168.0.0/24"]
    }
    private = {
      name    = "${local.common_name}_vnet_private"
      address = ["192.168.1.0/24"]
    }
    service = {
      name    = "${local.common_name}_vnet_service"
      address = ["192.168.2.0/24"]
      service = ["Microsoft.Keyvault", "Microsoft.Storage"]
      private = true
    }
  }
}

# Key vault module.
module "keyvault" {
  source = "./keyvault"
  depends_on = [
    module.network,
    azurerm_resource_group.group
  ]

  client_role  = "Key Vault Administrator"
  common_name  = local.common_name
  kv_link_name = "kvprivatelink.com"
  kv_zone_name = "privatelink.vaultcore.azure.net"
  location     = "eastus"
  network_id   = module.network.vnet_id
  project_tags = local.tags
  ip_rules     = ["76.100.143.150"]
  rg_name      = local.recource_group_name
  subnet_id    = module.network.service_subnet_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  principal_id = data.azurerm_client_config.current.object_id
  bypass       = "AzureServices"
}

# User identity module.
module "identity" {
  source = "./identity"
  depends_on = [
    module.network,
    module.keyvault,
    azurerm_resource_group.group
  ]

  location      = "eastus"
  role          = "Key Vault Crypto Service Encryption User"
  identity_name = "${local.common_name}_uai"
  keyvault_id   = module.keyvault.vault_id
  project_tags  = local.tags
  rg_name       = local.recource_group_name
}

# Storage account module.
module "storage" {
  source = "./storage"
  depends_on = [
    module.network,
    module.keyvault,
    module.identity,
    azurerm_resource_group.group
  ]

  assigned_id  = module.identity.user_identity_id
  identity_ids = [module.identity.user_identity_id]
  key_size     = 2048
  key_type     = "RSA"
  common_name  = local.common_name
  location     = "eastus"
  project_tags = local.tags
  rg_name      = local.recource_group_name
  subnet_id    = module.network.service_subnet_id
  vault_id     = module.keyvault.vault_id
  network_id   = module.network.vnet_id
  st_link_name = "stzonelink.come"
  st_zone_name = "privatelink.blob.core.windows.net"
}
