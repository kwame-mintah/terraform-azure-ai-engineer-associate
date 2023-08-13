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

module "custom_vision_service_training" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-custom-version-training"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "CustomVision.Training"
  personal_ip_address = var.personal_ip_address
  sku_name            = "F0"

  tags = merge(
    var.tags
  )
}

module "custom_vision_service_prediction" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-custom-version-prediction"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "CustomVision.Prediction"
  personal_ip_address = var.personal_ip_address
  sku_name            = "F0"

  tags = merge(
    var.tags
  )
}

module "custom_question_answer_service" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-custom-qna-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "TextAnalytics"
  personal_ip_address = var.personal_ip_address
  sku_name            = "S"
  search_service_id   = azurerm_search_service.cognitive_search_service.id
  search_service_key  = azurerm_search_service.cognitive_search_service.primary_key


  tags = merge(
    var.tags
  )
  depends_on = [azurerm_search_service.cognitive_search_service]
}

resource "azurerm_search_service" "cognitive_search_service" {
  name                = "custom-qna-search-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  sku                 = "free"

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

module "media_services_video_indexer" {
  source              = "./modules/video_indexers"
  name                = "videoindexer"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  environment         = var.environment
  personal_ip_address = var.personal_ip_address

  tags = merge(
    local.common_tags
  )
}
