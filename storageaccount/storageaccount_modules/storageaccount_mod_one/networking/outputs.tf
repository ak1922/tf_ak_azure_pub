output "private_dnszone_name" {
  value = azurerm_private_dns_zone.private_dnszone.0.name
}

output "private_dnszone_id" {
  value = azurerm_private_dns_zone.private_dnszone.0.id
}

output "storage_endpoint_id" {
  value = azurerm_private_endpoint.storage_endpoint.id
}
