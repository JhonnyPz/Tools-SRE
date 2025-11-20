# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = "~> 1.0"
}

provider "azurerm" {
  features {}
}

# Create resource Group
module "rg" {
  source   = "../modules/general/resource-group"
  name     = upper("TFRG-${var.tags["Solution"]}-${var.tags["Environment"]}")
  location = var.location
  tags     = var.tags
}

# Create Virtual Network
module "vnet" {
  source                  = "../modules/networking/virtual-networks"
  vnet_name               = lower("vnet-${var.tags["Solution"]}")
  address_space           = var.vnet_address_space
  subnet_name             = "default"
  subnet_address_prefixes = var.vnet_subnet_address_prefixes
  resource_group_name     = module.rg.name
  location                = var.location
  tags                    = var.tags

  depends_on = [module.rg]
}

# Create Virutal Machine (VM) Linux
module "vm" {
  source              = "../modules/compute/iaas/linux-virtual-machine"
  vm_name             = upper("vmlnx${var.tags["Solution"]}")
  sku                 = var.sku
  username            = var.admin_username
  password            = var.admin_password
  subnet_id           = module.vnet.subnet_id
  resource_group_name = module.rg.name
  location            = var.location
  tags                = var.tags

  depends_on = [module.vnet]
}

# Create Rule Network Security Group (NSG)
module "nsg_ssh" {
  source                     = "../modules/networking/network-security-groups"
  name                       = lower("nsg-${var.tags["Solution"]}")
  destination_address_prefix = module.vm.private_ip_address
  enable_nic_nsg_association = var.enable_nic_nsg_association
  network_interface_id       = module.vm.network_interface_id
  resource_group_name        = module.rg.name
  location                   = var.location
  tags                       = var.tags

  depends_on = [module.vm]
}
