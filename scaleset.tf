locals {
    #first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgM1v9Xugrdcvh3NqDMt3k7j5cut5VG5ZRIuUze6mvqmnVqbQXDNavEATauCvZV2HN2pCV6akaOcljqPRPT3RsQGHANaf83DD7atDeipGK4RgpoVI3fkzTjNbcQ259xtINW+ZpYDoM1bvzy1yyW20bV1lV8DWUdepyxsXNSx/0w4eX2Ou2u57zCaHB0++xAUBiee2XPGvbLC7La4FOc+MBViGYnZOg8C6V9LPUf8XjGrJJ/CyOagREthzMsDqg5cc2D8XjQht1KnAfVsET03Kcfaion4FnZr45FQxL9fHOYOifuHppt210R8rJu+1bvp7aPjDji8/SyX/hMcoZQKbOQ== rsa-key-20210421"
    custom_data = <<-EOF
              #!/bin/bash
              instanceId=$(curl -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmId?api-version=2017-04-02&format=text")
              echo "Terraform baby!" >> index.html
              echo "<br>" >> index.html
              echo "This refresh brought to you by: $instanceId" >> index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}

resource "azurerm_linux_virtual_machine_scale_set" "vmscaleset" {
  name                            = "vmscaleset"
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  #upgrade_policy_mode            = "Manual"
  zone_balance                    = true
  zones                           = ["1","2"]
  custom_data                     = base64encode(local.custom_data)
  sku                             = "Standard_B1ls"
  instances                       = 2
  admin_username                  = var.admin_user
  #admin_password                  = var.admin_password
  #disable_password_authentication = false

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
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vnic0"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.public.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.vmss_lb_bpepool.id]
    }
  }
}