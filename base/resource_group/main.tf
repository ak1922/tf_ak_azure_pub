# Block to hold project tags
locals {
  project_tags = {
    cost_criteria = "intermediate"
    Managed_By    = "Terraform"
    gitrepo       = "tf_ak_azure_pub"
    project       = "resource_group"
  }

  group_name = join("", [replace(local.project_tags.gitrepo, "_", ""), "-rg"])
}

# Resource group for all resources in this repository.
resource "azurerm_resource_group" "resource_group" {
  name     = local.group_name
  location = "eastus"

  tags = local.project_tags
}
