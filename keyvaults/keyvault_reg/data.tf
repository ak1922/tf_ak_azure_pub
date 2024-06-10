# Data source AzureRM client.
data "azurerm_client_config" "current" {}

# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  name = "tfakazurepub-rg"
}

# Data source service subnet.
data "azurerm_subnet" "servicesub" {
  name                 = "tfakazurepub-vnet-pri-sub"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = "tfakazurepub-vnet"
}
