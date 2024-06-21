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
}

locals {
  dnszone_args = {
    link_name = join("-", [local.module_tags.project, "pdnsz", ".com"])
  }
}
