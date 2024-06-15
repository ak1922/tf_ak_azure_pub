# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  name = "tfakazurepub-rg"
}

# Data source Key Vault.
data "azurerm_key_vault" "keyvault" {
  name                = "tfakazurepub-kv"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
