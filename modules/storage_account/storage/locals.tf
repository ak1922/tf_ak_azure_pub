# Locals block for Key Vault key
locals {
  key_args = {
    key_name       = var.preferred_keyname != null ? var.preferred_keyname : join("-", [var.common_name, "kvkey"])
    key_expiration = var.preferred_key_expiration != null ? var.preferred_key_expiration : timeadd(timestamp(), "8760h")
    key_opts       = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
  }
}

# Locals block for storage account
locals {
  storage_args = {
    storage_name     = join("", [var.common_name, random_integer.number.result])
    account_tier     = var.project_tags.environment == "prod" ? "Premium" : "Standard"
    account_rep_type = var.project_tags.environment == "prod" ? "GRS" : "LRS"
    infra_enabled    = var.project_tags.environment == "prod" ? false : true
    default_action   = var.ip_rules != [] && var.bypass != [] ? "Deny" : "Allow"
  }
}

# Locals block for blobs
locals {
  blob_args = {
    versioning       = var.https_traffic == true ? true : false
    change_feed      = var.https_traffic == true ? true : false
    last_access      = var.https_traffic == true ? true : false
    container_delete = var.preferred_container_delete == null ? 90 : var.preferred_container_delete
    retention_policy = var.preferred_delete_retention == null ? 90 : var.preferred_delete_retention
    restore_policy   = var.preferred_restore_policy == null ? 60 : var.preferred_restore_policy
  }
}
