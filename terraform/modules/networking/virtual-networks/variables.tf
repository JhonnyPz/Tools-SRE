variable "name" {
  description = "The name of the Azure Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space (CIDR block) for the Azure Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet within the Virtual Network"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes (CIDR blocks) for the subnet within the Virtual Network"
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Virtual Network will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the Virtual Network will be deployed"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Virtual Network resources"
  type        = map(string)
  default     = {}
}

