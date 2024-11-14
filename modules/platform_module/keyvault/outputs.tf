output "vault_id" {
  value       = azurerm_key_vault.keyvault.id
  description = "Kay vault ID."
}

output "kv_dnszone_name" {
  value       = azurerm_private_dns_zone.kv_dns_zone.name
  description = "Name of key vault private dns zone."
}

output "kv_dnszone_id" {
  value       = azurerm_private_dns_zone.kv_dns_zone.id
  description = "ID of key vault private dns zone."
}
