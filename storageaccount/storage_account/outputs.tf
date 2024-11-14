output "storage_key_name" {
  value = "Customer managed key name is ${azurerm_key_vault_key.storage_key.name}"
  description = "Name of customer managed key"
}

output "keyvault_key_id" {
  value       = azurerm_key_vault_key.storage_key.id
  description = "The ID of Key Vault key(customer managed key)."
}

output "storage_name" {
  value = "Name of storage account is ${azurerm_storage_account.storage.name}"
  description = "Name of storage account."
}

output "storage_id" {
  value       = azurerm_storage_account.storage.id
  description = "The ID of the storage account."
}
