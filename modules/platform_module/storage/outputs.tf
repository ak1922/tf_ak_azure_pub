output "storage_id" {
  value       = azurerm_storage_account.storage.id
  description = "Storage account ID."
}

output "storage_endpoint_id" {
  value       = azurerm_private_endpoint.storage_endpoint.id
  description = "Storage account private endpoint ID."
}
