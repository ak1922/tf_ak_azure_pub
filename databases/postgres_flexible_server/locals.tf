# Locals block for project tags.
locals {
  project_tags = {
    managed_by = "Terraform"
    gitrepo    = "tf_azure_public"
    gitbranch  = "database"
    subbranch  = "database_psql"
  }
  common_name = trim(replace(local.project_tags.gitrepo, "_", ""), "tflic")
}
