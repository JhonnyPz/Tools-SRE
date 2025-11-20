# Variables Resource Group
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

# Variables Virtual Network
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "vnet_subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.0.0/28"]
}

# Variables Virtual Machine
variable "sku" {
  description = "Size/SKU of the virtual machine"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}

# Variables Network Security Group
variable "enable_nic_nsg_association" {
  description = "Enable Network Security Group association with NIC"
  type        = bool
  default     = true
}

# Variables Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "DEV"
    Solution    = "VM"
    DeployedBy  = "Terraform"
  }
}
