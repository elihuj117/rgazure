resource "azurerm_public_ip" "vmss_public_ip" {
    name                         = "vmss_public_ip"
    location                     = var.resource_group_location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Static"
    sku = "Standard"
    #domain_name_label            = var.domain
}

resource "azurerm_lb" "vmss_lb" {
    name                = "vmss_lb"
    location            = var.resource_group_location
    sku                 = "Standard"
    resource_group_name = var.resource_group_name
        frontend_ip_configuration {
            name                 = "PublicIPAddress"
            public_ip_address_id = azurerm_public_ip.vmss_public_ip.id
        }
}

resource "azurerm_lb_backend_address_pool" "vmss_lb_bpepool" {
    loadbalancer_id     = azurerm_lb.vmss_lb.id
    name                = "BackEndAddressPool"
    #resource_group_name = var.resource_group_name
}

resource "azurerm_lb_probe" "vmss_lb_probe" {
    resource_group_name = var.resource_group_name
    loadbalancer_id     = azurerm_lb.vmss_lb.id
    name                = "http-running-probe"
    port                = var.application_port
}

resource "azurerm_lb_rule" "vmss_lbnatrule" {
    resource_group_name = var.resource_group_name
    loadbalancer_id                = azurerm_lb.vmss_lb.id
    name                           = "http"
    protocol                       = "Tcp"
    frontend_port                  = var.application_port
    backend_port                   = var.application_port
    backend_address_pool_id        = azurerm_lb_backend_address_pool.vmss_lb_bpepool.id
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_id                       = azurerm_lb_probe.vmss_lb_probe.id
}