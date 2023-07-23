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

# Create resource Group : 5sec
resource "azurerm_resource_group" "rg" {
  name     = "TFRG-${var.prefix}"
  location = var.location
  tags = {
    Environment = "Infrastructure"
    Solution    = "Deployment-CICD"
    By          = "JhonnyPz"
  }
}

# Create Service Plan : 5sec
resource "azurerm_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create Web Application : 5sec
resource "azurerm_linux_web_app" "app" {
  name                = "webapp-${random_id.prefix.hex}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
  }
}

# ¡To create more environment so duplicate the previous block!