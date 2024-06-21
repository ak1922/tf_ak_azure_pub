# Private dns zone for storage if needed.
resource "azurerm_private_dns_zone" "private_dnszone" {
  count = var.provisioned_dnszone == true ? 0 : 1

  name                = var.dnszone_name
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.module_tags
}

# Private dns zone virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_vnet" {
  name                  = local.dnszone_args.link_name
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_id    = data.azurerm_virtual_network.virtual_network.id
  private_dns_zone_name = azurerm_private_dns_zone.private_dnszone.0.name

  depends_on = [
    azurerm_private_dns_zone.private_dnszone
  ]

  tags = local.module_tags

  lifecycle {
    replace_triggered_by = [
      azurerm_private_dns_zone.private_dnszone
    ]
  }
}
