# Data source resource group
data "azurerm_resource_group" "resource_group" {
  name = "tfakazurepub-rg"
}

# Data source public subnet.
data "azurerm_subnet" "public_subnet" {
  name                 = "tfakazurepub-vnet-pub-sub"
  virtual_network_name = "tfakazurepub-vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}
