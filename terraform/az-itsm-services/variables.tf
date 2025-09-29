variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default = {
    environment = "staging"
    project     = "itsm"
    owner       = "terraform"
  }
}

variable "name" {
  description = "Name of the resource group"
  type        = string
  default     = "itsm"
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