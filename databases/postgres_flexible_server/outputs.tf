output "encryption_key_id" {
  value       = azurerm_key_vault_key.encryption_key.id
  description = "The ID of Key Vault key."
}

output "identity_id" {
  value       = azurerm_user_assigned_identity.identity.id
  description = "The ID of User assigned identity"
}

output "identity_roleassignment_id" {
  value       = azurerm_role_assignment.identity_roleassignment.id
  description = "The ID of User identity role assignment to Key Vault."
}

output "postgres_server_id" {
  value       = azurerm_postgresql_flexible_server.postgres_server.id
  description = "The ID of Postgres flexible server."
}
