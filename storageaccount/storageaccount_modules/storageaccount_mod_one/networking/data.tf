# Data source resource group
data "azurerm_resource_group" "rg" {
  name = "tfakazurepub-rg"
}

# Data source private dns zone for storage
data "azurerm_private_dns_zone" "storage_dnszone" {
  count = var.provisioned_dnszone == true ? 1 : 0
  name  = var.dnszone_name
}

# Data source virtual network.
data "azurerm_virtual_network" "virtual_network" {
  name                = "tfakazurepub-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}
