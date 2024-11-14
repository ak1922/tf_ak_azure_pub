# Virtual network.
resource "azurerm_virtual_network" "virtual_network" {
  name                = join("_", [local.common_name, "vnet"])
  address_space       = var.address_space
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  tags = local.project_tags
}

# Subnets for virtual network.
resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = "${azurerm_virtual_network.virtual_network.name}_${each.key}"
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = lookup(each.value, "service_endpoints", null)
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", null) != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

# Network security groups.
resource "azurerm_network_security_group" "sec_group" {
  for_each = var.subnets

  location            = data.azurerm_resource_group.resource_group.location
  name                = "${azurerm_virtual_network.virtual_network.name}_${each.key}_nsg"
  resource_group_name = data.azurerm_resource_group.resource_group.name

  dynamic "security_rule" {
    for_each = var.security_rule

    content {
      access                     = "Deny"
      direction                  = "Inbound"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_address_prefix = "*"
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      description                = security_rule.value.description
      source_address_prefix      = security_rule.value.source_address
      destination_port_range     = security_rule.value.destination_range
    }
  }

  depends_on = [
    azurerm_subnet.subnet
  ]

  tags = local.project_tags
}
