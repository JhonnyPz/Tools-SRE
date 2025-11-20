output "id" {
  description = "The ID of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "The name of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "address_space" {
  description = "The address space of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.snet.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.snet.name
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.snet.address_prefixes
}

output "location" {
  description = "The location of the Azure Virtual Network"
  value       = azurerm_virtual_network.vnet.location
}

