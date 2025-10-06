output "rg" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "admin_username" {
  description = "Admin username for the VMs"
  value       = var.admin_username
}

output "admin_password" {
  description = "Admin password for the VMs"
  value       = var.admin_password
  sensitive   = true
}

output "public_ip_linux" {
  description = "Public IP address of the Linux VM"
  value       = var.enable_sdp ? azurerm_public_ip.public-ip-linux-sv[0].ip_address : null
}

output "public_ip_windows" {
  description = "Public IP address of the Windows VM"
  value       = var.enable_endpointcentral ? azurerm_public_ip.public-ip-windows-sv[0].ip_address : null
}

output "private_ip_linux" {
  description = "Private IP address of the Linux VM"
  value       = var.enable_sdp ? azurerm_network_interface.nic-linux-sv[0].private_ip_address : null
}

output "private_ip_windows" {
  description = "Private IP address of the Windows VM"
  value       = var.enable_endpointcentral ? azurerm_network_interface.nic-windows-sv[0].private_ip_address : null
}

output "private_ip_windows_db" {
  description = "Private IP address of the Windows DB VM"
  value       = var.enable_mssql ? azurerm_network_interface.nic-windows-db[0].private_ip_address : null
}

output "fqdn_linux" {
  description = "FQDN of the Linux VM"
  value       = var.enable_sdp ? azurerm_public_ip.public-ip-linux-sv[0].fqdn : null
}

output "fqdn_windows" {
  description = "FQDN of the Windows VM"
  value       = var.enable_endpointcentral ? azurerm_public_ip.public-ip-windows-sv[0].fqdn : null
}