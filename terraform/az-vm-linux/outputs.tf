# Outputs Resource Group
output "rg_name" {
  description = "Name of the resource group"
  value       = module.rg.name
}

output "rg_location" {
  description = "Region of the resource group"
  value       = module.rg.location
}

# Outputs Virtual Network and NSG
output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.vnet.name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.vnet.subnet_name
}

output "nsg_name" {
  description = "Name of the network security group"
  value       = module.nsg_ssh.name
}

# Outputs Virtual Machine
output "vm_name" {
  description = "Name of the virtual machine"
  value       = module.vm.name
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = module.vm.public_ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = module.vm.private_ip_address
}

output "vm_username" {
  description = "Admin username of the virtual machine"
  value       = var.admin_username
}
