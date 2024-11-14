# Data source AzureRM client.
data "azurerm_client_config" "current" {}

# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  name = "azurepub_rg"
}

# Data source service subnet.
data "azurerm_subnet" "service" {
  name                 = "azurepub_vnet_service"
  virtual_network_name = "azurepub_vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}
