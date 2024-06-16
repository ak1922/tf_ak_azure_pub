# Random number generator for storage account name.
resource "random_integer" "number" {
  min = 3
  max = 4
}

# Key Vault key for storage account encryption.
resource "azurerm_key_vault_key" "keyvault_key" {
  name         = "${local.storage_name}key1"
  key_vault_id = data.azurerm_key_vault.keyvault.id

  key_size = 2048
  key_type = "RSA"

  key_opts = [
    "sign",
    "verify",
    "encrypt",
    "decrypt",
    "wrapKey",
    "unwrapKey"
  ]

  expiration_date = "2025-05-11T00:00:00Z"
}

# Storage account.
resource "azurerm_storage_account" "storage" {
  name                = local.storage_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  enable_https_traffic_only         = var.enable_https_traffic_only
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.privatesubnet.id]
  }

  depends_on = [
    azurerm_key_vault_key.keyvault_key
  ]

  tags = local.project_tags
}

# Role assignment for storage account system identity.
resource "azurerm_role_assignment" "identity_roleassignment" {
  scope                = data.azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_storage_account.storage.identity[0].principal_id

  depends_on = [
    azurerm_storage_account.storage
  ]
}

# Customer managed key for storage account encryption.
resource "azurerm_storage_account_customer_managed_key" "storage_customerkey" {
  key_vault_id       = data.azurerm_key_vault.keyvault.id
  key_name           = azurerm_key_vault_key.keyvault_key.name
  storage_account_id = azurerm_storage_account.storage.id

  depends_on = [
    azurerm_storage_account.storage,
    azurerm_role_assignment.identity_roleassignment,
  ]
}

# Private endpoint for storage account blobs.
resource "azurerm_private_endpoint" "storage_endpoint" {
  name                = "${local.storage_name}-pep"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  subnet_id           = data.azurerm_subnet.privatesubnet.id

  private_dns_zone_group {
    name                 = "${local.storage_name}-pdnszg"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.dnszone.id]
  }

  private_service_connection {
    name                           = "${local.storage_name}-pricon"
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = azurerm_storage_account.storage.id
  }

  tags = local.project_tags

  depends_on = [
    azurerm_storage_account_customer_managed_key.storage_customerkey
  ]
}
