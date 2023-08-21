# Variables Resource Group
variable "prefix" {
  type    = string
  default = "example"
}

variable "location" {
  type    = string
  default = "eastus2"
}

# Variables Virtual Machine
variable "sku" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "username" {
  type    = string
  default = "adminuser"
}

