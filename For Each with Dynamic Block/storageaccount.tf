resource "azurerm_storage_account" "appstore566565637" {  
  name                     = "appstore566565637"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [
    azurerm_resource_group.appgrp
  ]

tags={
  for name,value in local.common_tags : name=>"${value}"
}
}

