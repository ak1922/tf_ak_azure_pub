locals {
  akstorage_tags = {
    cost_criteria = "intermediate"
    managed_by  = "Terraform"
    gitrepo     = "tf_ak_azure_pub"
    project     = "storageaccount"
    sub_project = "storage_account_reg"
  }
}
