output "keyvaylt_key_name" {
  value = azurerm_key_vault_key.keyvaylt_key.name
}

output "keyvaylt_key_id" {
  value = azurerm_key_vault_key.keyvaylt_key.id
}

output "storage_id" {
  value = azurerm_storage_account.storage.id
}
