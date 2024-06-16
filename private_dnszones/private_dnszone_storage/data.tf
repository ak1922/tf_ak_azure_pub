data "azurerm_resource_group" "resourcegroup" {
  for_each = toset(var.rg_name)

  name = each.value
}

# Data source virtual network.
data "azurerm_virtual_network" "virtualnetwork" {
  name                = "tfakazurepub-vnet"
  resource_group_name = element(var.rg_name, 1)
}

# Data source action group.
data "azurerm_monitor_action_group" "actiongroup" {
  name                = "aksheridanknox-ag"
  resource_group_name = element(var.rg_name, 0)
}
