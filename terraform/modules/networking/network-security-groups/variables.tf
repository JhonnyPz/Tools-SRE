variable "name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "destination_address_prefix" {
  description = "The destination address prefix (CIDR block) for security rules"
  type        = string
}

variable "location" {
  description = "The Azure region where the Network Security Group will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Network Security Group will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Network Security Group"
  type        = map(string)
  default     = {}
}
