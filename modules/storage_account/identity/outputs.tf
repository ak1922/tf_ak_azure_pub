output "user_identity_id" {
  value = azurerm_user_assigned_identity.user_identity.id
}

output "user_identity_role_id" {
  value = azurerm_role_assignment.user_identity_role.id
}
