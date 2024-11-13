resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address
  location            = var.location
  resource_group_name = var.rg_name

  tags = merge({ Name = var.vnet_name }, var.project_tags)
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet

  name                                      = each.value.name
  address_prefixes                          = each.value.address
  service_endpoints                         = each.value.service
  resource_group_name                       = var.rg_name
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = lookup(each.value, "private", false)
}
