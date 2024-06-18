# Data source ressource group.
data "azurerm_resource_group" "resource_group" {
  for_each = toset(var.rgname)
  name     = each.value
}

# Data source action group.
data "azurerm_monitor_action_group" "action_group" {
  name                = "aksheridanknox-ag"
  resource_group_name = element(var.rgname, 1)
}

# Data source virtual network.
data "azurerm_virtual_network" "virtual_network" {
  name                = "tfakazurepub-vnet"
  resource_group_name = element(var.rgname, 0)
}
