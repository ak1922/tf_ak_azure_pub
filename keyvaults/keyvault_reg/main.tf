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

# Private endpoint for Key Vault.
resource "azurerm_private_endpoint" "keyvault_endpoint" {
  name                = local.module_args.endpoint_name
  location            = var.location
  resource_group_name = element(var.rgnames, 1)
  subnet_id           = data.azurerm_subnet.servicesub.id

  private_dns_zone_group {
    name                 = join("", [replace(local.module_args.vault_name, "-kv", ""), "-kvpdnszg"])
    private_dns_zone_ids = [data.azurerm_private_dns_zone.keyvault_dnszone.id]
  }

  private_service_connection {
    name                           = join("", [replace(local.module_args.vault_name, "-kv", ""), "-pricon"])
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names
    private_connection_resource_id = azurerm_key_vault.keyvault.id
  }

  tags = local.project_tags
}

# Alert rules for Key Vault.
resource "azurerm_monitor_activity_log_alert" "alert_rule" {
  for_each = var.activity_log

  name                = each.value.name
  description         = each.value.description
  resource_group_name = element(var.rgnames, 1)
  scopes              = [azurerm_key_vault.keyvault.id]

  criteria {
    category       = var.category
    statuses       = each.value.criteria.statuses
    operation_name = each.value.criteria.operation_name
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.actiongroup.id
  }
}
