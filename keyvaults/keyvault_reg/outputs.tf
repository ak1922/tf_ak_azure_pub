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

output "keyvault_diagsettings_id" {
  value       = azurerm_monitor_diagnostic_setting.keyvault_diagsetting.id
  description = "The ID of diagnostic setting for key vault."
}

output "keyvault_endpoint_id" {
  value       = azurerm_private_endpoint.keyvault_endpoint.id
  description = "The ID of Key Vault private endpoint."
}

output "alert_rules" {
  value       = toset(values(azurerm_monitor_activity_log_alert.alert_rule).*.id)
  description = "All IDs for the alert rules."
}
