# Data source existing resource group.
data "azurerm_resource_group" "rg" {
  count = var.existing_rg == null ? 0 : 1
  name  = var.existing_rg
}

# Data source Azure client.
data "azurerm_client_config" "current" {}
