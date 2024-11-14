# Private dns zone for key vault.
resource "azurerm_private_dns_zone" "kv_dns_zone" {
  name                = var.kv_zone_name
  resource_group_name = var.rg_name

  tags = var.project_tags
}

# Private dns zone virtual network link.
resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_link" {
  name                  = var.kv_link_name
  resource_group_name   = var.rg_name
  virtual_network_id    = var.network_id
  private_dns_zone_name = azurerm_private_dns_zone.kv_dns_zone.name

  depends_on = [azurerm_private_dns_zone.kv_dns_zone]
}

# Key vault.
resource "azurerm_key_vault" "keyvault" {
  name                       = local.args.vault_name
  sku_name                   = local.args.sku
  tenant_id                  = var.tenant_id
  location                   = var.location
  resource_group_name        = var.rg_name
  soft_delete_retention_days = local.args.soft
  purge_protection_enabled   = local.args.purge
  enable_rbac_authorization  = local.args.rbac

  network_acls {
    ip_rules                   = var.ip_rules
    bypass                     = var.bypass
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
  }

  tags = var.project_tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_zone_link]
}

# Client role assignment.
resource "azurerm_role_assignment" "client_keyvault_role" {
  role_definition_name = var.client_role
  principal_id         = var.principal_id
  scope                = azurerm_key_vault.keyvault.id

  depends_on = [azurerm_key_vault.keyvault]
}

# Private endpoint for key vault.
resource "azurerm_private_endpoint" "keyvault_endpoint" {
  name                = "${azurerm_key_vault.keyvault.name}_pep"
  location            = var.location
  subnet_id           = var.subnet_id
  resource_group_name = var.rg_name

  private_dns_zone_group {
    name                 = "${azurerm_key_vault.keyvault.name}_pdgz"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_dns_zone.id]
  }

  private_service_connection {
    subresource_names              = local.args.sub_resource
    is_manual_connection           = local.args.manual
    name                           = "${azurerm_key_vault.keyvault.name}_pcon"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
  }

  tags = var.project_tags

  depends_on = [
    azurerm_key_vault.keyvault,
    azurerm_role_assignment.client_keyvault_role
  ]
}
