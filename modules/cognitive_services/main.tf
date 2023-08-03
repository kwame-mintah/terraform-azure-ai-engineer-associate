# Cognitive Services Module ---------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
}

resource "azurerm_cognitive_account" "cognitive_services_account" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind

  sku_name = var.sku_name

  tags = merge(
    local.common_tags
  )
}


resource "azurerm_monitor_activity_log_alert" "cognitive_services_alert" {
  name                = "${var.name}-activitylogalert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_cognitive_account.cognitive_services_account.id]
  description         = "This alert will monitor Cognitive Services API account list keys."

  criteria {
    resource_id    = azurerm_cognitive_account.cognitive_services_account.id
    operation_name = "Microsoft.CognitiveServices/accounts/listKeys/action" # https://learn.microsoft.com/en-us/rest/api/cognitiveservices/accountmanagement/operations/list?tabs=HTTP#code-try-0
    category       = "Administrative"
  }

  tags = merge(
    local.common_tags
  )
}
