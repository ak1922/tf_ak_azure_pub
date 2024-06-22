# User identity for storage account.
resource "azurerm_user_assigned_identity" "user_identity" {
  name                = local.identity_args.identity_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.module_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Role assignment for User Identity
resource "azurerm_role_assignment" "user_identity_role" {
  role_definition_name = var.role
  description          = local.identity_args.role_description
  scope                = data.azurerm_key_vault.keyvault.id
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id

  depends_on = [
    azurerm_user_assigned_identity.user_identity
  ]

  lifecycle {
    precondition {
      condition = data.azurerm_key_vault.keyvault.enable_rbac_authorization == true
      error_message = "RBAC has to be enabled on Key Vault to successfuly compplete this role assignment."
    }

    replace_triggered_by = [
        azurerm_user_assigned_identity.user_identity
     ]
  }
}
