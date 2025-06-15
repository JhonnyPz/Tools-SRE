output "name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "admin_username" {
  description = "Admin username for the VMs"
  value       = azurerm_windows_virtual_machine.vm-windows-sv.admin_username
}

output "admin_password" {
  description = "Admin password for the VMs"
  value       = azurerm_windows_virtual_machine.vm-windows-sv.admin_password
  sensitive   = true
}

output "vm_private_ip_sv" {
  description = "Private IP address of the VM Widnows Server Adctive Directory"
  value       = azurerm_network_interface.nic-windows-sv.private_ip_address
}

output "vm_private_ip_client" {
  description = "Private IP address of the VM Widnows Server Adctive Directory"
  value       = azurerm_network_interface.nic-windows-client.private_ip_address
}

output "public_ip_bastion" {
  description = "Public IP address of the Bastion Host"
  value       = azurerm_public_ip.public-ip-bastion.ip_address
}