# User identity for storage account.
resource "azurerm_user_assigned_identity" "user_identity" {
  name                = var.identity_name
  location            = var.location
  resource_group_name = var.rg_name

  lifecycle {
    create_before_destroy = true
  }

  tags = merge({ Name = var.identity_name}, var.project_tags)
}

# Role assignment for User Identity
resource "azurerm_role_assignment" "identity_keyvault_role" {
  role_definition_name = var.role
  scope                = var.keyvault_id
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id

  lifecycle {
    replace_triggered_by = [azurerm_user_assigned_identity.user_identity]
  }

  depends_on = [azurerm_user_assigned_identity.user_identity]
}
