variable "vm_name" {
  description = "Name of the Linux virtual machine"
  type        = string
}


variable "sku" {
  description = "Size/SKU of the virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be connected"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
