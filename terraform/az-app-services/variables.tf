# Variables Resource Group
variable "prefix" {
  type        = string
  default     = "example"
  description = "Un prefijo que se utilizará para nombrar los recursos del grupo de recursos y recursos asociados"
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "La ubicación geográfica en la que se crearán los recursos."
}