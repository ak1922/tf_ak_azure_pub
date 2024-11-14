# Key Vault.
resource "azurerm_key_vault" "keyvault" {
  name                = join("", [local.common_name, "kv"])
  sku_name            = var.sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  purge_protection_enabled   = var.purge_protect
  soft_delete_retention_days = var.soft_delete

  enabled_for_deployment          = var.enabled_deployment
  enable_rbac_authorization       = var.rbac_authorization
  enabled_for_disk_encryption     = var.disk_encryption
  enabled_for_template_deployment = var.template_deployment

  network_acls {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.service.id]
  }

  tags = local.project_tags
}

# Role assignment to client for Key vault access.
resource "azurerm_role_assignment" "client_keyvault_role" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = var.client_role
  principal_id         = data.azurerm_client_config.current.object_id
}
