output "user_identity_id" {
  value       = azurerm_user_assigned_identity.user_identity.id
  description = "User identity ID"
}
