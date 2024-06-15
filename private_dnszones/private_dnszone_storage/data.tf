# Data source resource group.
data "azurerm_resource_group" "resourcegroup" {
  name = "tfakazurepub-rg"
}

# Data source virtual network.
data "azurerm_virtual_network" "virtualnetwork" {
  name                = "tfakazurepub-vnet"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}
