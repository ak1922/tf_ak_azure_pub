# VM ssh keys.
resource "tls_private_key" "vmkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# VM ssh key file.
resource "local_file" "vmkey_file" {
  filename = "linuxvmkey.pem"
  content  = tls_private_key.vmkey.private_key_pem
}

# VM public ip.
resource "azurerm_public_ip" "vm_pip" {
  name                = "linixvm_pip"
  allocation_method   = "Static"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  tags = local.module_tags
}

# VM network interphase.
resource "azurerm_network_interface" "vm_nic" {
  name                = "linuxvm_nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "linuxvmnic_ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.public_subnet.id
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }

  depends_on = [
    azurerm_public_ip.vm_pip
  ]

  tags = local.module_tags
}

# VM network security group.
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "linuxvm_nsg"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  tags = local.module_tags
}

# VM network security group rule.
resource "azurerm_network_security_rule" "vm_nsg_rule" {
  name                        = "pc_access"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = "73.128.169.71"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
}

# VM security group network interphase association.
resource "azurerm_network_interface_security_group_association" "vmnic_vmnsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id

  depends_on = [
    azurerm_network_security_rule.vm_nsg_rule
   ]
}

# Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "linuxvm"
  size                = "Standard_B1ms"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_username = "linadmin"
  admin_password = "ghYT65&%dbw7gd"

  admin_ssh_key {
    username   = "linadmin"
    public_key = tls_private_key.vmkey.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.module_tags

  depends_on = [
    azurerm_network_interface_security_group_association.vmnic_vmnsg
   ]
}
