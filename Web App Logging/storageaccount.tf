resource "azurerm_storage_account" "webstore281" {
  name                     = "webstore281"
  resource_group_name      = "app-grp"
  location                 = "North Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.webstore281.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.webstore281
  ]
}

data "azurerm_storage_account_blob_container_sas" "accountsas" {
  connection_string = azurerm_storage_account.webstore281.primary_connection_string
  container_name=azurerm_storage_container.logs.name
  https_only        = true  
  
  start  = "2022-06-01"
  expiry = "2022-06-30"

  permissions {
    read   = true
    add    = true
    create = false
    write  = true
    delete = true
    list   = true
  }
  depends_on = [
    azurerm_storage_account.webstore281
  ]
}

output "sas" {
  value=nonsensitive("https://${azurerm_storage_account.webstore281.name}.blob.core.windows.net/${azurerm_storage_container.logs.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}")
  }