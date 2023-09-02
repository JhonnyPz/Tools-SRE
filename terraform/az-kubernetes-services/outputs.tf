# Outputs resource Group
output "rg-name" {
  value       = azurerm_resource_group.rg.name
  description = "Name resource group"
}

output "rg-location" {
  value       = azurerm_resource_group.rg.location
  description = "Region of resources"
}

# Outputs resources aks
output "acr-name" {
  value       = azurerm_container_registry.acr.name
  description = "Name container registry"
}

output "aks-name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Name Kubernetes Services"
}
