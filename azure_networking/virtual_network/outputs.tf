output "virtual_network_name" {
  value = "The name of your virtual network is ${azurerm_virtual_network.virtual_network.name}."
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.virtual_network.id
  description = "The ID of the virtual network."
}

output "subnet_id" {
  value       = toset(values(azurerm_subnet.subnet).*.id)
  description = "All subnet IDs"
}

output "security_group_ids" {
  value       = values(azurerm_network_security_group.sec_group).*.id
  description = "IDs for network security groups."
}
