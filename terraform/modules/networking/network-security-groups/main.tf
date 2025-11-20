resource "azurerm_network_security_group" "nsg-ssh" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "SSH"
    priority                   = 1000
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = var.destination_address_prefix
  }

  tags = merge(var.tags, {
    "Type" = "Network Security Group"
  })
}

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  count                     = var.enable_nic_nsg_association ? 1 : 0
  network_interface_id      = var.network_interface_id
  network_security_group_id = azurerm_network_security_group.nsg-ssh.id
}
