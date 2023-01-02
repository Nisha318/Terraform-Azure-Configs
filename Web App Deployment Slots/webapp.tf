resource "azurerm_service_plan" "companyplan" {
  name                = "companyplan"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Windows"
  sku_name            = "S1"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_windows_web_app" "NishaApp" {
  name                = "NishaApp"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.companyplan.id

  site_config {
    application_stack {
      current_stack="dotnet"
      dotnet_version="v6.0"
    }
  }


logs {
    detailed_error_messages = true 
http_logs {
    azure_blob_storage {
        retention_in_days = 7 
        sas_url = "https://${azurerm_storage_account.webstore281.name}.blob.core.windows.net/${azurerm_storage_container.logs.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}"
    }
} 



}
  depends_on = [
    azurerm_service_plan.companyplan
  ]
}

