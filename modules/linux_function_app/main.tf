# Linux Function App ----------------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_service_plan" "linux_service_plan" {
  name                = "${var.name}-${var.service_plan}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.service_plan
  worker_count        = 2

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_linux_function_app" "linux_function_app" {
  name                 = "${var.name}${random_string.resource_code.result}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  service_plan_id      = azurerm_service_plan.linux_service_plan.id
  storage_account_name = var.storage_account_name

  site_config {
    application_stack {
      node_version = 18
    }
  }
}

