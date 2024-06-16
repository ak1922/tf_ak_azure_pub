# Data source resource group.
data "azurerm_resource_group" "resourcegroup" {
  name = "tfakazurepub-rg"
}

# Data source Key Vault.
data "azurerm_key_vault" "keyvault" {
  name                = "tfakazurepub-kv"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}

# Data source private subnet.
data "azurerm_subnet" "privatesubnet" {
  name                 = "tfakazurepub-vnet-pri-sub"
  virtual_network_name = "tfakazurepub-vnet"
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
}

# Data source private dns zone.
data "azurerm_private_dns_zone" "dnszone" {
  name = "privatelink.blob.core.windows.net"
}
