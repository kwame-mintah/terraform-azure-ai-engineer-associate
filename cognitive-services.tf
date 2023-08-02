module "cognitive_services" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-cognitive-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "CognitiveServices"

  tags = merge(
    var.tags
  )
}

resource "azurerm_key_vault" "cognitive_services_key_vault" {
  name                       = "${var.environment}-cognitive" # Vault name must be between 3 and 24 characters in length
  location                   = azurerm_resource_group.environment_rg.location
  resource_group_name        = azurerm_resource_group.environment_rg.name
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

resource "azurerm_key_vault_secret" "cognitive_services_primary_access_key" {
  name            = "${var.environment}-cognitive-services-primary-access-key"
  value           = module.cognitive_services.cognitive_services_primary_access_key
  key_vault_id    = azurerm_key_vault.cognitive_services_key_vault.id
  expiration_date = "2024-12-31T00:00:00Z"
  content_type    = "text/plain"
}
