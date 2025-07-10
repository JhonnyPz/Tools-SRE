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
  value       = azurerm_windows_virtual_machine.w_vm.admin_username
}

output "admin_password" {
  description = "Admin password for the VMs"
  value       = azurerm_windows_virtual_machine.w_vm.admin_password
  sensitive   = true
}

output "vm_public_ip_client" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.public-ip.ip_address
}