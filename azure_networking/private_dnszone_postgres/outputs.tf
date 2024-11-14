output "postgres_dns_id" {
  value       = azurerm_private_dns_zone.postgres_dns.id
  description = "The ID of private dns zone for Postgres"
}

output "dnszone_vnet_id" {
  value       = azurerm_private_dns_zone_virtual_network_link.dnszone_vnet.id
  description = "The ID of virtual network private dns zone link."
}

output "log_alert_ids" {
  value       = toset(values(azurerm_monitor_activity_log_alert.log_alert).*.id)
  description = "The IDs of the alert rules."
}
