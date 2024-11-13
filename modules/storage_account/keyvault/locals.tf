locals {
  args = {
    vault_name   = join("", [var.common_name, "kv"])
    sku          = "standard"
    soft         = 7
    purge        = true
    rbac         = true
    sub_resource = ["Vault"]
    manual       = false
  }
}
