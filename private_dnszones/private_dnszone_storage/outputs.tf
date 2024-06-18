output "storage_dnszone_id" {
  value       = azurerm_private_dns_zone.storage_dnszone.id
  description = "The ID of the private dns zone."
}

output "alert_rule_ids" {
  value = values(azurerm_monitor_activity_log_alert.alert_rule).*.id
  description = "The IDs of activity log alert rules"
}
