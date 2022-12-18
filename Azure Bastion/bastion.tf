/*

The following links provide the documentation for the new blocks used
in this terraform configuration file

1. azurerm_bastion_host - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host

*/

resource "azurerm_subnet" "bastionsubnet" {  
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = ["10.0.10.0/24"]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

resource "azurerm_public_ip" "bastionip" {  
  name                = "bastion-ip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static" 
  sku = "Standard" 
 depends_on = [
   azurerm_resource_group.appgrp
 ]
}

resource "azurerm_bastion_host" "appbastion" {
  name                = "appbastion"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }
}