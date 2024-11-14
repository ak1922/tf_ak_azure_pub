locals {
  project_tags = {
    cost_criteria     = "intermediate"
    Managed_By        = "Terraform"
    gitrepo           = "tf_ak_azure_pub"
    project           = "databases"
    sub_project       = "databases_postgre"
    sub_project_addon = "databases_postgre_flex"
  }

  common_name = join("", [replace(local.project_tags.gitrepo, "_", "")])
}

locals {
  module_args = {
    server_name     = join("", [local.common_name, "-psqlsrv"])
    keyname         = join("", [local.common_name, "-psqlsrv", "-encryptionkey01"])
    identity_name   = join("", [local.common_name, "-psqlsrv", "-uai"])
    key_expiration  = timeadd(timestamp(), "8000h")
    diagnostic_name = join("", [local.common_name, "-psqlsrv", "-diagsettings"])
  }
}
