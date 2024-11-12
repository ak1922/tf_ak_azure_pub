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

# Locals block for dns zone arguments.
locals {
  dnszone_args = {
    link_name = join("", [local.module_tags.project, "-pdnsz", ".com"])
  }
}

# Locals block for private enapoint arguments.
locals {
  endpoint_args = {
    endpoint_name = join("", [local.common_name, "-pep"])
    group_name    = join("", [local.common_name, "-pdnszg"])
    private_name  = join("", [local.common_name, "-priconn"])
  }
}
