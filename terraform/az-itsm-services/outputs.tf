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

output "public_ip_linux" {
  description = "Public IP address of the Linux VM"
  value       = azurerm_public_ip.public-ip-linux-sv.ip_address
}

output "public_ip_windows" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.public-ip-windows-sv.ip_address
}

output "private_ip_linux" {
  description = "Private IP address of the Linux VM"
  value       = azurerm_network_interface.nic-linux-sv.private_ip_address
}

output "private_ip_windows" {
  description = "Private IP address of the Windows VM"
  value       = azurerm_network_interface.nic-windows-sv.private_ip_address
}

output "private_ip_windows_db" {
  description = "Private IP address of the Windows DB VM"
  value       = azurerm_network_interface.nic-windows-db.private_ip_address
}