# Outputs resource Group
output "rg-name" {
  value       = azurerm_resource_group.rg.name
  description = "Name resource group"
}

output "rg-location" {
  value       = azurerm_resource_group.rg.location
  description = "Region of resources"
}

# Outputs Virtual Machine
output "vm-name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "Name Virtual Machine"
}

output "vm-username" {
  value       = azurerm_linux_virtual_machine.vm.admin_username
  description = "User name"
}

output "vm-ip" {
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
  description = "Public IP"
}
