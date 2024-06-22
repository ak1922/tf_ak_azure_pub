# Locals block to hold module tags.
locals {
  module_tags = {
    cost_criteria     = "intermediate"
    managed_by        = "Terraform"
    gitrepo           = "tf_ak_azure_pub"
    project           = "storageaccount"
    sub_project       = "storageaccount_modules"
    sub_project_addon = "storageaccount_modules_one"
    environment       = "dev"
  }

  common_name = join("", [local.module_tags.project, var.app_name])
}

# Locals block for Key Vault key
locals {
  key_args = {
    key_name       = var.preferred_keyname != null ? var.preferred_keyname : join("", [local.common_name, "-keyvaultkey"])
    key_expiration = var.preferred_key_expiration != null ? var.preferred_key_expiration : timeadd(timestamp(), "8760")
    key_opts       = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
  }
}

# Locals block for storage account
locals {
  storage_args = {
    storage_name     = join("", [local.common_name, random_integer.number.result])
    account_tier     = local.module_tags.environment == "dev" ? "Standard" : "Premium"
    account_rep_type = local.module_tags.environment == "dev" ? "LRS" : "GRS"
    infra_enabled    = local.module_tags.environment == "dev" ? false : true
    default_action   = var.ip_rules != [] && var.bypass != [] ? "Deny" : "Allow"
  }
}

# Locals block for blobs
locals {
  blob_args = {
    container_delete = var.preferred_container_delete != null ? var.preferred_container_delete : 90
    retention_policy = var.preferred_delete_retention != null ? var.preferred_delete_retention : 90
    restore_policy   = var.preferred_restore_policy != null ? var.preferred_restore_policy : 60
    versioning       = var.enable_https_traffic_only == true && var.preferred_container_delete != null ? true : false
    change_feed      = var.enable_https_traffic_only == true && var.preferred_container_delete != null ? true : false
    last_access      = var.enable_https_traffic_only == true && var.preferred_container_delete != null ? true : false
  }
}
