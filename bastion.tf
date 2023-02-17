resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion_public_ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion_nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "bastion_ip"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion_vm" {
  name                            = "bastion_vm"
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.bastion_nic.id]
  size                            = "Standard_B1ls"
  disable_password_authentication = true
  computer_name                   = "bastion-vm"
  admin_username                  = var.admin_user
  
  admin_ssh_key { 
    username   = var.admin_user
    public_key = file("id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "bastion_osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

}