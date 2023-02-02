resource "azurerm_subnet" "public" {
    count = "${length(var.subnets_public_network)}"
    name = "${var.subnets_public_name[count.index]}.${var.resource_group_name}.${var.domain}"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["${var.subnets_public_network[count.index]}"]
}

resource "azurerm_subnet" "private" {
    count = "${length(var.subnets_private_network)}"
    name = "${var.subnets_private_name[count.index]}.${var.resource_group_name}.${var.domain}"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["${var.subnets_private_network[count.index]}"]
}

resource "azurerm_subnet" "vpn" {
    count = "${length(var.subnets_vpn_network)}"
    name = "${var.subnets_vpn_name[count.index]}.${var.resource_group_name}.${var.domain}"
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = ["${var.subnets_vpn_network[count.index]}"]

}