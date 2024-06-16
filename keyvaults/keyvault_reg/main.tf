# Key Vault.
resource "azurerm_key_vault" "keyvault" {
  name     = local.module_args.vault_name
  sku_name = var.sku_name
  location = var.location

  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enabled_for_deployment          = var.enabled_for_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = element(var.rgnames, 1)

  network_acls {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.servicesub.id]
  }

  tags = local.project_tags
}

# Role assignment for Key Vault.
resource "azurerm_role_assignment" "keyvault_roleassignment" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Diagnostic settings for Key Vault.
resource "azurerm_monitor_diagnostic_setting" "keyvault_diagsetting" {
  name               = local.module_args.dgset_name
  target_resource_id = azurerm_key_vault.keyvault.id

  enabled_log {
    category = "AuditEvent"
  }

  storage_account_id = data.azurerm_storage_account.storage.id
}
