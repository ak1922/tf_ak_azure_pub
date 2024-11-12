# Data source resource group.
data "azurerm_resource_group" "rg" {
  name = "tfakazurepub-rg"
}

# Data source key vault.
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.rg.name
}
