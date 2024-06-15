# Private dns zone for storage blobs.
resource "azurerm_private_dns_zone" "storage_dnszone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  tags = local.project_tags
}

# Private dns zone virtual network link.
resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_vnet" {
  name                  = "storageblob-pdnszlink.com"
  resource_group_name   = data.azurerm_resource_group.resourcegroup.name
  private_dns_zone_name = azurerm_private_dns_zone.storage_dnszone.name
  virtual_network_id    = data.azurerm_virtual_network.virtualnetwork.id

  tags = local.project_tags

  lifecycle {
    replace_triggered_by = [azurerm_private_dns_zone.storage_dnszone]
  }

  depends_on = [
    azurerm_private_dns_zone.storage_dnszone
  ]
}
