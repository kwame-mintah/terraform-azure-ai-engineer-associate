# Bot Web App Module ----------------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
}

data "azurerm_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

# Creates an Azure Bot Web App resource with dynamic naming, specified location, 
# resource group, SKU, and Microsoft App ID, along with merged tags.
resource "azurerm_bot_web_app" "bot_service" {
  name                = "${var.name}-${random_string.resource_code.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  microsoft_app_id    = data.azurerm_client_config.current.client_id

  tags = merge(
    local.common_tags
  )
}

# Defines an Azure AD Application with a dynamic display name, prevents duplicate names, 
# assigns owners based on conditions, and adds relevant tags, including ones ignored for removal.
resource "azuread_application" "aad_application" {
  display_name            = "${var.name}-app-${random_string.resource_code.result}"
  prevent_duplicate_names = true
  owners                  = var.app_owners != "" ? [data.azurerm_client_config.current.object_id, var.app_owners] : [data.azurerm_client_config.current.object_id]

  tags = [
    "Managed By Terraform",
    "webApp",      # Created by Azure, added so its ignored instead of being removed.
    "apiConsumer", # Created by Azure, added so its ignored instead of being removed.
  ]
}

# Creates an Azure AD Application Password associated with the specified application object ID and 
# dynamic display name, enabling automatic rotation triggered by changes and dependent on an Azure AD Application 
# and a time-based rotation configuration.
resource "azuread_application_password" "aad_application_password" {
  application_object_id = azuread_application.aad_application.object_id
  display_name          = "${var.name}-app-${random_string.resource_code.result}"

  rotate_when_changed = {
    rotation = time_rotating.aad_application_password_rotation.id
  }

  depends_on = [azuread_application.aad_application]
}

# Configures a time-based rotation for Azure AD Application Passwords, triggering a rotation every 180 days.
resource "time_rotating" "aad_application_password_rotation" {
  rotation_days = 180
}

