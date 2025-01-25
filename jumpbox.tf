resource "azurerm_network_interface" "this" {
  name                = "jumpbox-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "jumpbox-ipconfig"
    subnet_id                     = azurerm_subnet.jumpbox.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_windows_virtual_machine" "jumpbox" {
  name                = "UC3B-vm"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_D4s_v3"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-entn"
    version   = "latest"
  }
  depends_on = [ azurerm_resource_group.this ]
}