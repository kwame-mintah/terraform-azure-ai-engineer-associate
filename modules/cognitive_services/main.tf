# Cognitive Services Module ---------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
  shorten_name          = substr(var.name, 0, 3)
  kind_remove_fullstops = replace(var.kind, ".", "-")
  shorten_kind          = substr(local.kind_remove_fullstops, 0, 17)
}

data "azurerm_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 3
  special = false
  upper   = false
}

resource "azurerm_cognitive_account" "cognitive_services_account" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind

  sku_name                                     = var.sku_name
  custom_question_answering_search_service_id  = var.search_service_id
  custom_question_answering_search_service_key = var.search_service_key

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_key_vault" "cognitive_services_key_vault" {
  name                       = lower("${local.shorten_name}-${local.shorten_kind}${random_string.resource_code.result}") # Vault name must be between 3 and 24 characters in length.
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

# FIXME: If a storage account is created, then an Azure Role assignment is neeed.
# The cognitive resource will need to be assigned the role 'Storage Blob Data Contributor' (?) or
# will not be able to access the container blob when retriving items for training a model via SDK.
# Need to manually add this via the Azure Portal console:
# Open the cognitive service created -> Identity -> Azure Role assignments -> '+ Add role assignment (Preview)'
# Scope: Storage, Subscription: Select your own, Role: Storage Blob Data Contributor and save changes.
resource "azurerm_storage_account" "cognitive_service_storage" {
  count                           = var.create_storage_account ? 1 : 0
  name                            = lower("${local.shorten_name}${local.shorten_kind}${random_string.resource_code.result}")
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true # Ideally this would be false, however needs a VNET to be created.
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false

  network_rules {
    default_action = "Deny"
    bypass         = ["Metrics", "AzureServices"]
    ip_rules       = [var.personal_ip_address] # Should be your own IP address, or won't be able to apply changes.

    private_link_access {
      endpoint_resource_id = azurerm_cognitive_account.cognitive_services_account.id
    }
  }

  queue_properties {
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_storage_container" "cognitive_service_container" {
  count                = var.create_storage_account ? 1 : 0
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.cognitive_service_storage[0].name
  #checkov:skip=CKV_AZURE_34:The Azure example provided the azure-ai-formrecognizer uses a SAS token when trying models(?)
  container_access_type = "blob"
}
