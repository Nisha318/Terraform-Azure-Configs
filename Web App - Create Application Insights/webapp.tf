resource "azurerm_service_plan" "companyplan" {
  name                = "companyplan"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Windows"
  sku_name            = "B1"
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

  app_settings = {
  "APPINSIGHTS_INSTRUMENTATIONKEY" =azurerm_application_insights.appinsights.instrumentation_key
   "APPLICATIONINSIGHTS_CONNECTION_STRING"=azurerm_application_insights.appinsights.connection_string
}
  depends_on = [
    azurerm_service_plan.companyplan
  ]
}

