# Linux Function App ----------------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
  shorten_name       = substr(var.name, 0, 17)
  kind_remove_hypens = replace(local.shorten_name, "-", "")
  storage_name       = "${local.kind_remove_hypens}${random_string.resource_code.result}"
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

# Defines an Azure App Service Plan with specified attributes, including name, location, 
# resource group, OS type, SKU, worker count, and merged tags.
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

# Creates an Azure Linux Function App with dynamic naming, specified location, resource group, 
# associated service plan, and storage account, along with the application stack configuration specifying 
# Node.js version 18, and dependencies on the Cognitive Service Storage Account.
resource "azurerm_linux_function_app" "linux_function_app" {
  name                 = "${var.name}${random_string.resource_code.result}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  service_plan_id      = azurerm_service_plan.linux_service_plan.id
  storage_account_name = local.storage_name

  site_config {
    application_stack {
      node_version = 18
    }
  }

  depends_on = [azurerm_storage_account.cognitive_service_storage]
}

# Defines an Azure Storage Account for Cognitive Services, with specified attributes including name, resource group, 
# location, tier, replication type, kind, minimum TLS version, public network access settings, network rules, queue 
# properties for metrics and logging, system-assigned identity, and merged tags, while ignoring changes related to customer-managed keys.
resource "azurerm_storage_account" "cognitive_service_storage" {
  name                            = lower(local.storage_name)
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

  tags = merge(
    local.common_tags
  )

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}
