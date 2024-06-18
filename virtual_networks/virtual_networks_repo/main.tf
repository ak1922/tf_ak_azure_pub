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
  service_endpoints    = each.value.service_endpoints
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  resource_group_name  = data.azurerm_resource_group.resource_group.name

  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled

  delegation {
    name = each.value.name
    service_delegation {
      name    = each.value.name
      actions = each.value["actions"]
    }
  }
}

# resource "azurerm_subnet" "postgres_subnet" {
#   name                 = "tfakazurepub-vnet-ppsqldb-sub"
#   address_prefixes     = ["192.168.0.16/29"]
#   virtual_network_name = azurerm_virtual_network.virtual_network.name
#   resource_group_name  = data.azurerm_resource_group.resource_group.name

#   delegation {
#     name = "pgfs"

#     service_delegation {
#       name = "Microsoft.DBforPostgreSQL/flexibleServers"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action"
#       ]
#     }
#   }
# }
