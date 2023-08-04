# Outputs resource Group
output "rg-name" {
  value       = azurerm_resource_group.rg.name
  description = "Name resource group"
}

output "rg-location" {
  value       = azurerm_resource_group.rg.location
  description = "Region of resources"
}

# Outputs resources web
output "acr-name" {
  value       = azurerm_container_registry.acr.name
  description = "Name container registry"
}

output "plan-name" {
  value       = azurerm_service_plan.plan.name
  description = "Name service plan"
}

output "appweb-name" {
  value       = azurerm_linux_web_app.app.name
  description = "Name web application"
}