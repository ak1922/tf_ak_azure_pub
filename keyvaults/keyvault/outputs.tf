output "keyvault_name" {
  value = "The name of your Key Vault is ${azurerm_key_vault.keyvault.name}"
}

output "keyvault_id" {
  value       = azurerm_key_vault.keyvault.id
  description = "The ID of the Key Vault"
}
