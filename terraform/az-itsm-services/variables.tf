variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default = {
    environment = "staging"
    project     = "itsm"
    owner       = "terraform"
  }
}

variable "prefix" {
  description = "Prefix of the resources  to be created"
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
  default     = "itsmadmin"
}

variable "admin_password" {
  description = "Admin password for the VMs"
  type        = string
  sensitive   = true
}

variable "enable_sdp" {
  description = "Enable ServiceDesk for the resources"
  type        = bool
  default     = true
}

variable "enable_endpointcentral" {
  description = "Enable Endpoint Central for the resources"
  type        = bool
  default     = false
}

variable "enable_analytics" {
  description = "Enable Analytics for the resources"
  type        = bool
  default     = false
}

variable "enable_mssql" {
  description = "Enable MSSQL for the resources"
  type        = bool
  default     = false
}