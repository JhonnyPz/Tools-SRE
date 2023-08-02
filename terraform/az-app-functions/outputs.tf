# Outputs resource Group
output "rg-name" {
  value       = azurerm_resource_group.rg.name
  description = "Name resource group"
}

output "rg-location" {
  value       = azurerm_resource_group.rg.location
  description = "Region of resources"
}

# Outputs resources function
output "name-plan" {
  value       = azurerm_service_plan.plan.name
  description = "Name service plan"
}

output "stg-account" {
  value       =  azurerm_storage_account.stg.name
  description = "Name storage account"
}

output "app-function" {
  value       = azurerm_linux_function_app.app.name
  description = "Name app function"
}