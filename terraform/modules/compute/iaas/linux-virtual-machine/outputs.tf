output "id" {
  description = "ID of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "name" {
  description = "Name of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip_address" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.pip.ip_address
}

output "private_ip_address" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "network_interface_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.nic.id
}

output "public_ip_id" {
  description = "ID of the public IP resource"
  value       = azurerm_public_ip.pip.id
}
