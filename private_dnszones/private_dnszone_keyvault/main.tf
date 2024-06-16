# Private dns zone for Key Vault.
resource "azurerm_private_dns_zone" "keyvault_dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = element(var.rgnames, 1)

  tags = local.project_tags
}

# Private dns zone virtual network link.
resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_vnet" {
  name                  = "keyvault-pdnszlink.com"
  resource_group_name   = element(var.rgnames, 1)
  private_dns_zone_name = azurerm_private_dns_zone.keyvault_dns.name
  virtual_network_id    = data.azurerm_virtual_network.virtual_network.id

  tags = local.project_tags

  lifecycle {
    replace_triggered_by = [azurerm_private_dns_zone.keyvault_dns]
  }

  depends_on = [
    azurerm_private_dns_zone.keyvault_dns
  ]
}

# Activity log alert for Key Vault private dns zone.
resource "azurerm_monitor_activity_log_alert" "alerts" {
  for_each = var.activity_log

  name                = each.value.name
  description         = each.value.description
  scopes              = [azurerm_private_dns_zone.keyvault_dns.id]
  resource_group_name = element(var.rgnames, 1)

  criteria {
    category       = each.value.criteria.category
    operation_name = each.value.criteria.operation_name
    levels         = each.value.criteria.levels
    statuses       = each.value.criteria.statuses
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.actiongroup.id
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dnszone_vnet
  ]
}
