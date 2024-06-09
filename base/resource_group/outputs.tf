output "resource_group_name" {
  value = "${azurerm_resource_group.resource_group.name} is the name of our resource group"
}

output "resource_group_id" {
  value       = azurerm_resource_group.resource_group.id
  description = "The ID of resource group."
}
