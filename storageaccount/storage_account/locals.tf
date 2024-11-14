# Locals block for project tags.
locals {
  project_tags = {
    managed_by = "Terraform"
    gitrepo    = "tf_azure_public"
    gitbranch  = "azure_storage"
    subbranch  = "azure_storage_sa"
  }
  common_name = trim(replace(local.project_tags.gitrepo, "_", ""), "tflic")
}

# Locals block for storage arguments.
locals {
  storage_args = {
    name          = join("", [local.common_name, "sadiagloggig"])
    identity      = "SystemAssigned"
    identity_role = "Key Vault Crypto Service Encryption User"
    version       = true
    change_feed   = true
    last_access   = true
  }
}

# Locals block for key vault key arguments.
locals {
  key_args = {
    name   = join("-", [local.storage_args.name, "kvkey"])
    type   = "RSA"
    size   = 2048
    expire = "2025-05-11T00:00:00Z"
    ops    = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  }
}
