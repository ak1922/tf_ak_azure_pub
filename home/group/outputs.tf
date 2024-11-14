output "group_id" {
  value       = azurerm_resource_group.resource_group.id
  description = "Resource group ID."
}

output "action_group_id" {
  value       = azurerm_monitor_action_group.action_group.id
  description = "Action group ID."
}
