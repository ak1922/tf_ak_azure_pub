output "virtual_network_name" {
  value = "The name of your virtual network is ${azurerm_virtual_network.virtual_network.name}."
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.virtual_network.id
  description = "The ID of the virtual network."
}
