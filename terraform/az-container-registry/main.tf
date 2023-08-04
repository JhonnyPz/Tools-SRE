# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.60.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "azurerm" {
  features {}
}

resource "random_id" "prefix" {
  byte_length = 2
}

# Create resource Group
resource "azurerm_resource_group" "rg" {
  name     = "TFRG-${var.prefix}"
  location = var.location
  tags = {
    Environment = "Infrastructure"
    Solution    = "Deployment-CICD"
    By          = "JhonnyPz"
  }
}

# Create Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry${random_id.prefix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Create Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create Web Application
resource "azurerm_linux_web_app" "app" {
  name                = "webapp-${random_id.prefix.dec}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id

  /*identity {
    type = "SystemAssigned"
  }*/

  site_config {
    container_registry_use_managed_identity = true
    application_stack {
      docker_image     = "mcr.microsoft.com/appsvc/staticsite"
      docker_image_tag = "latest"
      #docker_image_name        = "app:latest"
      #docker_registry_url      = "https://${data.azurerm_container_registry.acr.login_server}"
      #docker_registry_username = azurerm_container_registry.acr.admin_username
      #docker_registry_password = azurerm_container_registry.acr.admin_password
    }
  }

  app_settings = {
    #acrUseManagedIdentityCreds = true
    DOCKER_REGISTRY_SERVER_URL      = azurerm_container_registry.acr.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  }
}

/*resource "azurerm_role_assignment" "app" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.app.identity[0].principal_id
}*/