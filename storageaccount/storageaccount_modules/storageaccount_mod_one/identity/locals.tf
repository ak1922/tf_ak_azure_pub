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

# Locals block to hold argument values in this identity sub module.
locals {
  identity_args = {
    identity_name    = join("", [local.common_name, "-uai"])
    role_description = "Role assignment to grant access to Key Vault in data source."
  }
}
