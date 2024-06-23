# Virtual network.
resource "azurerm_virtual_network" "virtual_network" {
  name                = join("", [replace(local.project_tags.gitrepo, "_", ""), "-vnet"])
  location            = var.location
  address_space       = var.address_space
  resource_group_name = data.azurerm_resource_group.resource_group.name

  tags = local.project_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.name
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
