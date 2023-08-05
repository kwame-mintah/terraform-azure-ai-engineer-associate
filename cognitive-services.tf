module "cognitive_services" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-cognitive-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "CognitiveServices"
  personal_ip_address = var.personal_ip_address

  tags = merge(
    var.tags
  )
}

module "language_service" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-language-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "TextAnalytics"
  personal_ip_address = var.personal_ip_address
  sku_name            = "S"

  tags = merge(
    var.tags
  )
}

module "cognitive_services_container_language" {
  source                     = "./modules/container_instances"
  name                       = "language"
  image                      = "mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest"
  environment                = var.environment
  resource_group_name        = azurerm_resource_group.environment_rg.name
  cognitive_service_api_key  = module.cognitive_services.cognitive_services_primary_access_key
  cognitive_service_endpoint = module.cognitive_services.cognitive_services_endpoint

  tags = merge(
    local.common_tags
  )
}
