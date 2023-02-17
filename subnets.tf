resource "azurerm_subnet" "public" {
    name = "${var.subnets_public_name}"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["${var.subnets_public_network}"]
}

resource "azurerm_subnet" "private" {
    name = "${var.subnets_private_name}"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["${var.subnets_private_network}"]
}

#resource "azurerm_subnet" "vpn" {
#    name = "${var.subnets_vpn_name}.${var.resource_group_name}.${var.domain}"
#    resource_group_name = var.resource_group_name
#    virtual_network_name = azurerm_virtual_network.vnet01.name
#    address_prefixes = ["${var.subnets_vpn_network}"]
#}