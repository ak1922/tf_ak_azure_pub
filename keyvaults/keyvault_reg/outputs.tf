output "keyvault_name" {
  value = "The name of your Key Vault is ${azurerm_key_vault.keyvault.name}"
}

output "keyvault_id" {
  value       = azurerm_key_vault.keyvault.id
  description = "The ID of the Key Vault"
}

output "client_object_id" {
  value = "The object_id ${data.azurerm_client_config.current.object_id} is the client_id and also the person running this terraform module"
}
