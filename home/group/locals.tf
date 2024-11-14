# Locals block for project tags.
locals {
  project_tags = {
    managed_by = "Terraform"
    gitrepo    = "tf_azure_public"
    gitbranch  = "home"
    subbranch  = "group"
  }
  common_name = trim(replace(local.project_tags.gitrepo, "_", ""), "tflic")
}
