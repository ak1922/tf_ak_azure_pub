# Key Vault.
resource "azurerm_key_vault" "keyvault" {
  name     = local.vault_name
  sku_name = var.sku_name
  location = var.location

  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enabled_for_deployment          = var.enabled_for_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = data.azurerm_resource_group.resource_group.name

  network_acls {
    default_action = var.default_action
    bypass = var.bypass
    ip_rules = var.ip_rules
    virtual_network_subnet_ids = [ "" ]
  }

  tags = local.project_tags
}

# Role assignment for Key Vault.
resource "azurerm_role_assignment" "keyvault_roleassignment" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}
