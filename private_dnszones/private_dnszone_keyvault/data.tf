# Data source resource groups.
data "azurerm_resource_group" "resourcegroup" {
  for_each = toset(var.rgnames)
  name     = each.value
}

# Data source action group.
data "azurerm_monitor_action_group" "actiongroup" {
  name                = "aksheridanknox-ag"
  resource_group_name = element(var.rgnames, 0)
}

# Data source virtual network.
data "azurerm_virtual_network" "virtual_network" {
  name                = "tfakazurepub-vnet"
  resource_group_name = element(var.rgnames, 1)
}
