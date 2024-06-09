# Data source AzureRM client.
data "azurerm_client_config" "current" {}

# Data source resource group.
data "azurerm_resource_group" "resource_group" {
  name = "tfakazurepub-rg"
}
