resource "azurerm_resource_group" "appgrp" {
  name     = local.resource_group_name
  location = local.location  
}

resource "random_uuid" "storageaccountidentifier" {
  
}

output "randomid" {
  value=substr(random_uuid.storageaccountidentifier.result,0,8)
}

