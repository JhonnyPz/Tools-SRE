variable "name" {
  description = "Name of the resource group"
  type        = string
  default     = "example"
}

variable "location" {
  description = "Location of the resource group"
  type        = string
  default     = "East US 2"
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "Admin password for the VMs"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}

variable "private_ip_address" {
  description = "Private IP address for the VM Windows server AD"
  type        = string
  default     = "10.0.1.5"
}