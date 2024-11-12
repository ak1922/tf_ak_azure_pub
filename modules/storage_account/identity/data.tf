data "azurerm_resource_group" "rg" {
  name = "tfakazurepub-rg"
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.rg.name
}
