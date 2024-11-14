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

resource "azurerm_network_security_group" "security_group" {
  for_each = var.subnet

  name                = "${each.value.name}_nsg"
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = var.security_rule

    content {
      name                       = security_rule.value.name
      description                = security_rule.value.description
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_address_prefix = "*"
      source_address_prefix      = security_rule.value.source_address
      destination_port_range     = security_rule.value.destination_range
    }
  }

  tags = var.project_tags
  depends_on = [azurerm_subnet.subnet]
}
