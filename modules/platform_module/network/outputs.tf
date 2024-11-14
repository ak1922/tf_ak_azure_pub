output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Name of virtual network."
}

output "service_subnet_id" {
  value       = azurerm_subnet.subnet["service"].id
  description = "ID of service subnet"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID of virtual network."
}
