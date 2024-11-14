# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  name = "azurepub_rg"
}

# Data source Key Vault.
data "azurerm_key_vault" "keyvault" {
  name                = "azurepubkv"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

# Data source service subnet.
data "azurerm_subnet" "service" {
  name                 = "azurepub_vnet_service"
  virtual_network_name = "azurepub_vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}
