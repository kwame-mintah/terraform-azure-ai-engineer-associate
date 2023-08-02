# Create Azure Storage for Terraform

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

resource "azurerm_resource_group" "environment_rg" {
  name     = "${var.environment}-rg"
  location = var.location
  tags = merge(
    local.common_tags
  )
}

resource "azurerm_storage_account" "tfstate" {
  name                            = "tfstate${var.environment}${random_string.resource_code.result}"
  resource_group_name             = azurerm_resource_group.environment_rg.name
  location                        = azurerm_resource_group.environment_rg.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true # Ideally this would be false, however needs a VNET to be created.
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
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

  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-${var.environment}"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Customer Managed Key (CMK) for storage

resource "azurerm_key_vault" "tfstate_key_vault" {
  name                       = "tfstate-${var.environment}-cmk"
  location                   = azurerm_resource_group.environment_rg.location
  resource_group_name        = azurerm_resource_group.environment_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"] # This is silly, remove it when you're done.
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Create",
      "Get"
    ]
    secret_permissions = [
      "Get"
    ]
    storage_permissions = [
      "Get"
    ]
  }
  tags = merge(
    local.common_tags
  )
}

resource "azurerm_key_vault_key" "tfstate_key_vault_key" {
  name            = "tfstate-${var.environment}-key"
  key_vault_id    = azurerm_key_vault.tfstate_key_vault.id
  key_type        = "RSA-HSM"
  key_size        = 2048
  key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  expiration_date = "2024-12-31T00:00:00Z"
  tags = merge(
    local.common_tags
  )
}

resource "azurerm_storage_account_customer_managed_key" "tfstate_cmk" {
  storage_account_id = azurerm_storage_account.tfstate.id
  key_vault_id       = azurerm_key_vault.tfstate_key_vault.id
  key_name           = azurerm_key_vault_key.tfstate_key_vault_key.name
}

# Storage account logging for blobs

resource "azurerm_log_analytics_workspace" "tfstate_analytics_workspace" {
  name                = "tfstate-${var.environment}-workspace"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  sku                 = "Free"
  retention_in_days   = 30
  tags = merge(
    local.common_tags
  )
}

resource "azurerm_log_analytics_storage_insights" "tfstate_analytics_storage_insights" {
  name                = "tfstate-${var.environment}-storage-insight-config"
  resource_group_name = azurerm_resource_group.environment_rg.name
  workspace_id        = azurerm_log_analytics_workspace.tfstate_analytics_workspace.id
  storage_account_id  = azurerm_storage_account.tfstate.id
  storage_account_key = azurerm_storage_account.tfstate.primary_access_key
}
