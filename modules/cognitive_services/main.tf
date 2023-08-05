# Cognitive Services Module ---------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
  shorten_name = substr(var.name, 0, 3)
}

data "azurerm_client_config" "current" {}

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

resource "azurerm_key_vault" "cognitive_services_key_vault" {
  name                       = lower("${local.shorten_name}-${var.kind}") # Vault name must be between 3 and 24 characters in length.
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = [var.personal_ip_address] # Should be your own IP address, or won't be able to apply changes.
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id # This will allow the Terraform client the ability to add keys
    key_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "GetRotationPolicy",
      "SetRotationPolicy",
      "Rotate",
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_key_vault_secret" "cognitive_services_primary_access_key" {
  name            = lower("${var.name}-primary-access-key")
  value           = azurerm_cognitive_account.cognitive_services_account.primary_access_key
  key_vault_id    = azurerm_key_vault.cognitive_services_key_vault.id
  expiration_date = "2024-12-31T00:00:00Z"
  content_type    = "text/plain"
}

resource "azurerm_key_vault_secret" "cognitive_services_secondary_access_key" {
  name            = lower("${var.name}-secondary-access-key")
  value           = azurerm_cognitive_account.cognitive_services_account.secondary_access_key
  key_vault_id    = azurerm_key_vault.cognitive_services_key_vault.id
  expiration_date = "2024-12-31T00:00:00Z"
  content_type    = "text/plain"
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
