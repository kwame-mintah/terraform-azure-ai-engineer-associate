# Machine Learning Module -----------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
  environment   = substr(var.environment, 0, 3)
  name_shorten  = substr(var.name, 0, 17)
  remove_hypens = replace(local.name_shorten, "-", "")
  storage_name  = "${local.environment}${local.remove_hypens}${random_string.resource_code.result}"
}

data "azurerm_client_config" "current" {}

resource "random_string" "resource_code" {
  length  = 3
  special = false
  upper   = false
}

# Machine Learning workspace
resource "azurerm_machine_learning_workspace" "machine_learning_workspace" {
  name                          = lower("${local.environment}-${var.name}")
  location                      = var.location
  resource_group_name           = var.resource_group_name
  application_insights_id       = azurerm_application_insights.machine_learning_key_insights.id
  key_vault_id                  = azurerm_key_vault.machine_learning_key_vault.id
  storage_account_id            = azurerm_storage_account.machine_learning_storage.id
  container_registry_id         = azurerm_container_registry.machine_learining_container_registry.id
  public_network_access_enabled = true #checkov:skip=CKV_AZURE_144:No VPN or VNET has been created for this project

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_application_insights.machine_learning_key_insights,
    azurerm_key_vault.machine_learning_key_vault,
    azurerm_storage_account.machine_learning_storage,
    azurerm_container_registry.machine_learining_container_registry
  ]
}

# Compute Cluster
resource "azurerm_machine_learning_compute_cluster" "machine_learning_compute_cluster" {
  name                          = lower("${local.environment}-${var.name}-cluster")
  location                      = var.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.machine_learning_workspace.id
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_DS11_V2"
  local_auth_enabled            = false

  identity {
    type = "SystemAssigned"
  }

  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 1
    scale_down_nodes_after_idle_duration = "PT2M" # 2 minutes
  }

  depends_on = [azurerm_machine_learning_workspace.machine_learning_workspace]
}

resource "azurerm_application_insights" "machine_learning_key_insights" {
  name                = lower("${local.environment}-${var.name}-insights")
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_key_vault" "machine_learning_key_vault" {
  name                       = lower("${local.environment}-${local.name_shorten}${random_string.resource_code.result}") # Vault name must be between 3 and 24 characters in length.
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

  tags = merge(
    local.common_tags
  )
}

resource "azurerm_storage_account" "machine_learning_storage" {
  name                            = lower(local.storage_name)
  location                        = var.location
  resource_group_name             = var.resource_group_name
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
      customer_managed_key #checkov:skip=CKV2_AZURE_1:Customer managed key to be created later.
    ]
  }

  tags = merge(
    local.common_tags
  )
}


# Default action has been set to Allow as no subnet has been created for these resources,
# see error message returned below:
# The network configuration for the storage account does not allow access from the compute. 
# Please allow access from all networks or put the compute and the storage in the same subnet.
#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-allow-microsoft-service-bypass
resource "azurerm_storage_account_network_rules" "machine_learning_network_rules" {
  storage_account_id = azurerm_storage_account.machine_learning_storage.id
  default_action     = "Allow" #checkov:skip=CKV_AZURE_35:Need to set to set to allow for clusters as no VNET is created

  depends_on = [azurerm_storage_account.machine_learning_storage]
}

resource "azurerm_container_registry" "machine_learining_container_registry" {
  #checkov:skip=CKV_AZURE_139:Requires upgrde to premium sku tier to enable additional networking configurations
  #checkov:skip=CKV_AZURE_163:quarantine_policy_enabled, retention_policy, trust_policy, export_policy_enabled and zone_redundancy_enabled are only supported on resources with the Premium SKU.
  #checkov:skip=CKV_AZURE_164:quarantine_policy_enabled, retention_policy, trust_policy, export_policy_enabled and zone_redundancy_enabled are only supported on resources with the Premium SKU.
  #checkov:skip=CKV_AZURE_165:quarantine_policy_enabled, retention_policy, trust_policy, export_policy_enabled and zone_redundancy_enabled are only supported on resources with the Premium SKU.
  #checkov:skip=CKV_AZURE_166:The georeplications is only supported on new resources with the Premium SKU.
  #checkov:skip=CKV_AZURE_167:quarantine_policy_enabled, retention_policy, trust_policy, export_policy_enabled and zone_redundancy_enabled are only supported on resources with the Premium SKU.
  name                          = "${local.environment}${local.remove_hypens}${random_string.resource_code.result}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  admin_enabled                 = false
  public_network_access_enabled = false
  sku                           = "Basic"

  identity {
    type = "SystemAssigned"
  }
}
