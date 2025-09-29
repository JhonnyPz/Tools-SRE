resource "azurerm_resource_group" "rg" {
  name     = upper("TF-RG-${var.name}")
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name}-${var.tags["environment"]}"
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
    name             = "subnet-private-1"
    address_prefixes = ["10.0.15.0/24"]
    security_group   = azurerm_network_security_group.nsg.id
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.name}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowAny-RDP-AnyInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAny-SSH-AnyInbound"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAny-MSSQL-AnyInbound"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 1433
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAny-ITSM-AnyInbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [8020, 8080, 8443, 8027, 8444]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "nic-linux-sv" {
  name                = "nic-linux-sv-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[0].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.10.4"
    public_ip_address_id          = azurerm_public_ip.public-ip-linux-sv.id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm-linux-sv" {
  name                = "vm-linux-${var.name}-${var.tags["environment"]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  computer_name       = upper("LNX01${var.name}")
  size                = "Standard_B2as_v2"

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic-linux-sv.id,
  ]

  # admin_ssh_key {
  #   username   = "azure"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = var.tags
}

resource "azurerm_network_interface" "nic-windows-sv" {
  name                = "nic-windows-sv-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[2].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.20.4"
    public_ip_address_id          = azurerm_public_ip.public-ip-windows-sv.id
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm-windows-sv" {
  name                = "vm-windows-${var.name}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  computer_name       = upper("WS01${var.name}")
  size                = "Standard_B2as_v2"
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

  tags = var.tags
}

resource "azurerm_network_interface" "nic-windows-db" {
  name                = "nic-windows-db-${var.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-private"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[1].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.15.4"
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm-windows-db" {
  name                = "vm-windows-db-${var.name}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  computer_name       = upper("WSDB01${var.name}")
  size                = "Standard_B2as_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic-windows-db.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftsqlserver"
    offer     = "sql2022-ws2022"
    sku       = "sqldev-gen2"
    version   = "latest"
  }

  tags = var.tags
}



resource "azurerm_public_ip" "public-ip-linux-sv" {
  name                = "pip-lnx-${var.name}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "azurerm_public_ip" "public-ip-windows-sv" {
  name                = "pip-ws-${var.name}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}