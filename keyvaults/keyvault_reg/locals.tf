# Block to hold project tags
locals {
  project_tags = {
    cost_criteria = "intermetiate"
    managed_by    = "Terraform"
    gitrepo       = "tf_ak_azure_pub"
    project       = "keyvaults"
    sub_project   = "keyvault_reg"
  }

  vault_name = join("", [replace(local.project_tags.gitrepo, "_", ""), "-kv"])
}
