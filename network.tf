resource "azurerm_virtual_network" "vnet01" {
    name                = "${var.vnet_name}.${var.resource_group_name}.${var.domain}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    address_space       = [var.vnet_cidr]

    tags = {
        Name = "${var.vnet_name}.${var.resource_group_location}.${var.domain}"
    }
}