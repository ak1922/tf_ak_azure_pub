locals {
  project_tags = {
    cost_criteria = "intermediate"
    managed_by    = "Terraform"
    gitrepo       = "tf_ak_azure_pub"
    project       = "storageaccount"
    sub_project   = "storage_account_reg"
  }

  storage_name = join("", [replace(local.project_tags.gitrepo, "_", ""), random_integer.number.result])
}
