# Private dns zone for storage blobs.
resource "azurerm_private_dns_zone" "storage_dnszone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = element(var.rg_name, 1)

  tags = local.project_tags
}

# Private dns zone virtual network link.
resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_vnet" {
  name                  = "storageblob-pdnszlink.com"
  resource_group_name   = element(var.rg_name, 1)
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

# Alert rule.
resource "azurerm_monitor_activity_log_alert" "alert_rule" {
  for_each = var.activity_log

  name                = each.value.name
  description         = each.value.description
  scopes              = [data.azurerm_resource_group.resourcegroup["tfakazurepub-rg"].id]
  resource_group_name = element(var.rg_name, 1)

  criteria {
    resource_id    = azurerm_private_dns_zone.storage_dnszone.id
    category       = each.value.criteria.category
    operation_name = each.value.criteria.operation_name
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.actiongroup.id
  }
}
