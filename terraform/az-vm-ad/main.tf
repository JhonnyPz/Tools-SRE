resource "azurerm_resource_group" "rg" {
  name     = "TF-RG-${var.name}"
  location = var.location

  tags = {
    environment = "Development"
    created_by  = "Terraform"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet-public-1"
    address_prefixes = ["10.0.10.0/24"]
    security_group   = azurerm_network_security_group.nsg.id
  }

  subnet {
    name             = "subnet-public-2"
    address_prefixes = ["10.0.20.0/24"]
    security_group   = azurerm_network_security_group.nsg.id
  }

  subnet {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.5.0/26"]
    # security_group   = azurerm_network_security_group.nsg.id
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  # security_rule {
  #   name                       = "AllowAny-RDP-AnyInbound"
  #   priority                   = 1000
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = 3389
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_windows_virtual_machine" "vm-windows-sv" {
  name                = "vm-windows-sv-${var.name}-ad"
  computer_name       = "VM01DC"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic-windows-sv.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver"
    sku       = "2025-datacenter-azure-edition-smalldisk"
    version   = "latest"
  }

  patch_mode = "AutomaticByPlatform"

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_network_interface" "nic-windows-sv" {
  name                = "nic-windows-sv-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[0].id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_windows_virtual_machine" "vm-windows-client" {
  name                = "vm-windows-sv-${var.name}-client"
  computer_name       = "VM01GU"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2as_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic-windows-client.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-entn"
    version   = "latest"
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_network_interface" "nic-windows-client" {
  name                = "nic-windows-client-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[1].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = tolist(azurerm_virtual_network.vnet.subnet)[2].id
    public_ip_address_id = azurerm_public_ip.public-ip-bastion.id
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}

resource "azurerm_public_ip" "public-ip-bastion" {
  name                = "public-ip-bastion-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = "Production"
    created_by  = "Terraform"
  }
}