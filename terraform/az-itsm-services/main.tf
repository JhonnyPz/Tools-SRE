resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "rg" {
  name     = upper("TF-RG-${var.prefix}-${var.tags["environment"]}")
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.prefix}-${var.tags["environment"]}"
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
    address_prefixes = ["10.0.30.0/24"]
    security_group   = azurerm_network_security_group.nsg.id
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.prefix}-${var.tags["environment"]}"
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
    priority                   = 1001
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
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 1433
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AlloyAny-HTTPS-AnyInbound"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAny-ITSM-AnyInbound"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = [8020, 8080, 8443, 8027, 8442]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "nic-linux-sv" {
  count               = var.enable_sdp ? 1 : 0
  name                = "nic-linux-sv-${var.prefix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[0].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.10.4"
    public_ip_address_id          = azurerm_public_ip.public-ip-linux-sv[0].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm-linux-sv" {
  count               = var.enable_sdp ? 1 : 0
  name                = "vm-linux-${var.prefix}-${var.tags["environment"]}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  computer_name       = upper("LNX01${var.prefix}")
  size                = "Standard_B2as_v2"

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  allow_extension_operations = true
  provision_vm_agent         = true

  network_interface_ids = [
    azurerm_network_interface.nic-linux-sv[0].id,
  ]

  # admin_ssh_key {
  #   username   = "azure"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 32
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
  count               = var.enable_endpointcentral || var.enable_analytics ? 1 : 0
  name                = "nic-windows-sv-${var.prefix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-public"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[1].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.20.4"
    public_ip_address_id          = azurerm_public_ip.public-ip-windows-sv[0].id
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm-windows-sv" {
  count               = var.enable_endpointcentral || var.enable_analytics ? 1 : 0
  name                = "vm-windows-${var.prefix}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  computer_name       = upper("WS01${var.prefix}")
  size                = "Standard_B2as_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  allow_extension_operations = true
  provision_vm_agent         = true

  network_interface_ids = [
    azurerm_network_interface.nic-windows-sv[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 32
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
  count               = var.enable_mssql ? 1 : 0
  name                = "nic-windows-db-${var.prefix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-private"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[2].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.30.4"
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm-windows-db" {
  count               = var.enable_mssql ? 1 : 0
  name                = "vm-windows-db-${var.prefix}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  computer_name       = upper("WSDB01${var.prefix}")
  size                = "Standard_B2as_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  allow_extension_operations = true
  provision_vm_agent         = true

  network_interface_ids = [
    azurerm_network_interface.nic-windows-db[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 127
  }

  source_image_reference {
    publisher = "microsoftsqlserver"
    offer     = "sql2022-ws2022"
    sku       = "sqldev-gen2"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_mssql_virtual_machine" "example" {
  virtual_machine_id               = azurerm_windows_virtual_machine.vm-windows-db[0].id
  sql_license_type                 = "PAYG"
  r_services_enabled               = true
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = var.admin_password
  sql_connectivity_update_username = "sdp"
}

resource "azurerm_public_ip" "public-ip-linux-sv" {
  count               = var.enable_sdp ? 1 : 0
  name                = "pip-lnx-${var.prefix}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "lnxitsm-${random_id.suffix.hex}"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "azurerm_public_ip" "public-ip-windows-sv" {
  count               = var.enable_endpointcentral || var.enable_analytics ? 1 : 0
  name                = "pip-ws-${var.prefix}-${var.tags["environment"]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "wdsitsm-${random_id.suffix.hex}"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

# resource "azurerm_virtual_machine_extension" "linux-vm-extension" {
#   count                = var.enable_sdp ? 1 : 0
#   name                 = "linux-vm-extension-${var.prefix}"
#   virtual_machine_id   = azurerm_linux_virtual_machine.vm-linux-sv[0].id
#   publisher            = "Microsoft.Azure.Extensions"
#   type                 = "CustomScript"
#   type_handler_version = "2.0"

#   settings = <<SETTINGS
#     {
#   "commandToExecute": "cd /opt && wget https://archives.manageengine.com/service-desk/14980/ManageEngine_ServiceDesk_Plus.bin"
#     }
#   SETTINGS


#   tags = var.tags
# }