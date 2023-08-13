# Media Services Video Indexer Module -----------
# -----------------------------------------------

locals {
  arm_file_path = "${path.module}/arm/video_index.template.json"
  shorten_name  = substr(var.environment, 0, 3)
  common_tags = merge(
    var.tags
  )
}

resource "random_string" "resource_code" {
  length  = 3
  special = false
  upper   = false
}

#| Azure Media Services will be retired June 30th, 2024. Please see
#│ https://learn.microsoft.com/en-us/azure/media-services/latest/azure-media-services-retirement
resource "azurerm_media_services_account" "media_services" {
  name                        = "${var.name}${local.shorten_name}${random_string.resource_code.result}"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  storage_authentication_type = "System"

  storage_account {
    id         = azurerm_storage_account.media_storage.id
    is_primary = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    local.common_tags
  )
}

# Create video indexer (using arm template)
resource "azurerm_resource_group_template_deployment" "video_indexer" {
  resource_group_name = var.resource_group_name
  parameters_content = jsonencode({
    "name"                          = { value = "${var.name}-${random_string.resource_code.result}" },
    "managedIdentityResourceId"     = { value = azurerm_user_assigned_identity.video_indexer_user_assigned_identity.id },
    "mediaServiceAccountResourceId" = { value = azurerm_media_services_account.media_services.id },
    "tags"                          = { value = local.common_tags },
  })

  template_content = templatefile(local.arm_file_path, {})

  # The filemd5 forces this to run when the file is changed
  # this ensures the keys are up-to-date
  name            = "video-indexer-${filemd5(local.arm_file_path)}"
  deployment_mode = "Incremental"
  depends_on = [
    azurerm_media_services_account.media_services,
    azurerm_user_assigned_identity.video_indexer_user_assigned_identity,
    azurerm_role_assignment.video_indexer_media_services_access
  ]
}

# Create managed identify
resource "azurerm_user_assigned_identity" "video_indexer_user_assigned_identity" {
  name                = "video-indexer-user-identity-${random_string.resource_code.result}"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(
    local.common_tags
  )
}

# Create role assignement
resource "azurerm_role_assignment" "video_indexer_media_services_access" {
  scope                = azurerm_media_services_account.media_services.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.video_indexer_user_assigned_identity.principal_id
}

# Create storage account
resource "azurerm_storage_account" "media_storage" {
  name                            = "${var.name}${local.shorten_name}${random_string.resource_code.result}"
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

    # Ideally, this would be the video indexer id, but resource currently not created via Terraform but instead via ARM
    # private_link_access {
    #   endpoint_resource_id = <Video Indexer ID>
    # }
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
