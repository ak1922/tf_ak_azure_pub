# Locals block for module tags
locals {
  module_tags = {
    cost_criteria = "intermediate"
    Managed_By    = "Terraform"
    gitrepo       = "tf_ak_azure_pub"
    project       = "compute"
    sub_project   = "compute_vm_linux"
  }
}
