output "keyvault_dns_id" {
  value       = azurerm_private_dns_zone.keyvault_dns.id
  description = "The ID of private dns zone for Key Vault."
}

output "dnszone_vnet_id" {
  value       = azurerm_private_dns_zone_virtual_network_link.dnszone_vnet.id
  description = "The ID of private dns zone virtual network link."
}

output "alert_rule_ids" {
  value       = toset(values(azurerm_monitor_activity_log_alert.alerts).*.id)
  description = "The IDs for all the alert rules."
}
