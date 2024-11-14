output "keyvaultkey_name" {
  value = "Customer managed key name is ${azurerm_key_vault_key.keyvault_key.name}"
}

output "keyvault_key_id" {
  value       = azurerm_key_vault_key.keyvault_key.id
  description = "The ID of Key Vault key(customer managed key)."
}

output "storage_id" {
  value       = azurerm_storage_account.storage.id
  description = "The ID of the storage account."
}

output "storage_endpoint_id" {
  value       = azurerm_private_endpoint.storage_endpoint.id
  description = "The ID of the private endpoint for storage account."
}
