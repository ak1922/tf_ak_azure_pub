# Key Vault key for storage account encryption.
resource "azurerm_key_vault_key" "storage_key" {
  name            = local.key_args.name
  key_size        = local.key_args.size
  key_type        = local.key_args.type
  key_opts        = local.key_args.ops
  expiration_date = local.key_args.expire
  key_vault_id    = data.azurerm_key_vault.keyvault.id

  tags = local.project_tags
}

# Storage account.
resource "azurerm_storage_account" "storage" {
  name                      = local.storage_args.name
  location                  = data.azurerm_resource_group.resource_group.location
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only

  identity {
    type = local.storage_args.identity
  }

  network_rules {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.service.id]
  }

  blob_properties {
    container_delete_retention_policy {
      days = var.container_delete
    }
    restore_policy {
      days = var.restore_policy
    }
    delete_retention_policy {
      days = var.delete_retention
    }

    versioning_enabled       = local.storage_args.version
    change_feed_enabled      = local.storage_args.change_feed
    last_access_time_enabled = local.storage_args.last_access
  }

  depends_on = [azurerm_key_vault_key.storage_key]
  tags       = local.project_tags
}

# Role assignment for storage account system identity to Key Vault.
resource "azurerm_role_assignment" "identity_keyvault_role" {
  scope                = data.azurerm_key_vault.keyvault.id
  role_definition_name = local.storage_args.identity_role
  principal_id         = azurerm_storage_account.storage.identity[0].principal_id

  depends_on = [
    azurerm_storage_account.storage
  ]
}

# Customer managed key for storage account.
resource "azurerm_storage_account_customer_managed_key" "customer_key" {
  key_vault_id       = data.azurerm_key_vault.keyvault.id
  key_name           = azurerm_key_vault_key.storage_key.name
  storage_account_id = azurerm_storage_account.storage.id

  depends_on = [
    azurerm_role_assignment.identity_keyvault_role
  ]
}
