# Private dns zone for Postgres.
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = element(var.rgname, 0)

  tags = local.module_tags
}

# Private dns zone virtual network link.
resource "azurerm_private_dns_zone_virtual_network_link" "dnszone_vnet" {
  name                  = "postgres-pdnszlink.com"
  resource_group_name   = element(var.rgname, 0)
  virtual_network_id    = data.azurerm_virtual_network.virtual_network.id
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name

  lifecycle {
    replace_triggered_by = [azurerm_private_dns_zone.postgres_dns]
  }

  tags = local.module_tags
}

# Activity log alerts for private dns zone.
resource "azurerm_monitor_activity_log_alert" "log_alert" {
  for_each = var.activity_log

  name                = each.value.name
  description         = each.value.description
  scopes              = [azurerm_private_dns_zone.postgres_dns.id]
  resource_group_name = element(var.rgname, 0)

  criteria {
    category       = "Administrative"
    operation_name = each.value.criteria.operation_name
    levels         = each.value.criteria.levels
    statuses       = each.value.criteria.statuses
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.action_group.id
  }

  tags = local.module_tags
}
