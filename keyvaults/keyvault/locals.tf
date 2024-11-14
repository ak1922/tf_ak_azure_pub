# Block to hold project tags
locals {
  project_tags = {
    managed_by  = "Terraform"
    gitrepo     = "tf_azure_public"
    project     = "keyvaults"
    sub_project = "keyvault_kvep"
  }
  common_name = trim(replace(local.project_tags.gitrepo, "_", ""), "tflic")
}
