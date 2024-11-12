# Random number generator.
resource "random_integer" "number" {
  min = 4
  max = 5
}

# Key Vault key for storage account encryption.
resource "azurerm_key_vault_key" "keyvaylt_key" {
  name         = local.key_args.key_name
  key_vault_id = data.azurerm_key_vault.keyvault.id

  key_type = var.key_type
  key_size = var.key_size
  key_opts = local.key_args.key_opts

  rotation_policy {
    expire_after         = var.rotation_policy.expire_after
    notify_before_expiry = var.rotation_policy.notify_before_expire

    automatic {
      time_before_expiry = var.rotation_policy.time_before_expire
    }
  }

  expiration_date = local.key_args.key_expiration

  tags = local.module_tags
}

# Storage account.
resource "azurerm_storage_account" "storage" {
  name                = local.storage_args.storage_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  account_tier                      = local.storage_args.account_tier
  account_replication_type          = local.storage_args.account_rep_type
  infrastructure_encryption_enabled = local.storage_args.infra_enabled

  identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids
  }

  network_rules {
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    default_action             = local.storage_args.default_action
    virtual_network_subnet_ids = [data.azurerm_subnet.private_subnet.id]
  }

  customer_managed_key {
    user_assigned_identity_id = var.assigned_id
    key_vault_key_id          = azurerm_key_vault_key.keyvaylt_key.id
  }

  blob_properties {
    container_delete_retention_policy {
      days = local.blob_args.container_delete
    }

    delete_retention_policy {
      days = local.blob_args.retention_policy
    }

    restore_policy {
      days = local.blob_args.restore_policy
    }

    versioning_enabled       = var.versioning
    change_feed_enabled      = var.change_feed
    last_access_time_enabled = var.last_access
  }

  tags = local.module_tags

  depends_on = [
    azurerm_key_vault_key.keyvaylt_key
  ]
}

# Storage management policy.
resource "azurerm_storage_management_policy" "storage_mgmt" {
  for_each           = var.lifecycle_rules
  storage_account_id = azurerm_storage_account.storage.id

  rule {
    name = each.value.name

    filters {
      prefix_match = each.value.prefix_match
      blob_types   = each.value.blob_types
    }

    enabled = true

    actions {
      base_blob {
        tier_to_cool_after_days_since_creation_greater_than    = each.value.base_blob.days_to_cool
        tier_to_archive_after_days_since_creation_greater_than = each.value.base_blob.days_to_archive
      }
    }
  }

  depends_on = [
    azurerm_storage_account.storage
  ]
}
