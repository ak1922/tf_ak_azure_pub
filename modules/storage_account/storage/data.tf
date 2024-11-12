# Data source resource group.
data "azurerm_resource_group" "rg" {
  name = "tfakazurepub-rg"
}

# Data source Key Vault.
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Data source private subnet.
data "azurerm_subnet" "private_subnet" {
  name                 = "tfakazurepub-vnet-pri-sub"
  virtual_network_name = "tfakazurepub-vnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
}
