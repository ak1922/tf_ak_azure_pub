output "storage_dnszone_id" {
  value       = azurerm_private_dns_zone.storage_dnszone.id
  description = "The ID of the private dns zone."
}
