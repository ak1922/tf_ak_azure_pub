output "vm_pip_id" {
  value       = azurerm_public_ip.vm_pip.id
  description = "The ID of the public ip."
}

output "vm_nic_id" {
  value       = azurerm_network_interface.vm_nic.id
  description = "The ID of virtual machine network interphase."
}

output "vm" {
    value = azurerm_linux_virtual_machine.vm.id
    description = "The ID of virtual machine"
}
