# Create multi-account Cognitivie Service.
module "cognitive_services" {
  source                 = "./modules/cognitive_services"
  name                   = "${var.environment}-cognitive-service"
  location               = azurerm_resource_group.environment_rg.location
  resource_group_name    = azurerm_resource_group.environment_rg.name
  kind                   = "CognitiveServices"
  personal_ip_address    = var.personal_ip_address
  create_storage_account = true
  storage_container_name = "margies"

  tags = merge(
    var.tags
  )
}

# Create language service.
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

# Create custom vision service for training purposes.
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

# Create custom vision service for prediction purposes.
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

# Create form recognizer service.
module "form_recognizer" {
  source                 = "./modules/cognitive_services"
  name                   = "${var.environment}-form-recognizer"
  location               = azurerm_resource_group.environment_rg.location
  resource_group_name    = azurerm_resource_group.environment_rg.name
  kind                   = "FormRecognizer"
  personal_ip_address    = var.personal_ip_address
  sku_name               = "F0"
  create_storage_account = true
  storage_container_name = "sampleforms"

  tags = merge(
    var.tags
  )
}

# Create Azure OpenAI resource.
# You may not be able to create this resource please see here:
# To request access to the Azure OpenAI service, visit https://aka.ms/oaiapply.
module "open_ai" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-open-ai"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "OpenAI"
  personal_ip_address = var.personal_ip_address
  sku_name            = "S0"

  tags = merge(
    var.tags
  )
}

# Create language service for custom and answering purposes.
module "custom_question_answer_service" {
  source              = "./modules/cognitive_services"
  name                = "${var.environment}-custom-qna-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  kind                = "TextAnalytics"
  personal_ip_address = var.personal_ip_address
  sku_name            = "S"
  search_service_id   = azurerm_search_service.qna_search_service.id
  search_service_key  = azurerm_search_service.qna_search_service.primary_key


  tags = merge(
    var.tags
  )
  depends_on = [azurerm_search_service.qna_search_service]
}

# Create search service connected to custom question and anwsering service.
resource "azurerm_search_service" "qna_search_service" {
  name                = "${var.environment}-custom-qna-search-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  sku                 = "free"

  tags = merge(
    var.tags
  )
}

# Create search service.
# When importing data to the search service from a Azure Blob Storage,
# the Managed identity authentication selected must be "System-assigned"
# or will result in the follow error message being thrown: 
# Error detecting index schema from data source: "This request is not authorized to perform this operation."
# Additionally, you need to give the cognitive search service the role 'Storage Blob Data Contributor'
resource "azurerm_search_service" "cognitive_search_service" {
  name                = "${var.environment}-cognitive-search-service"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  sku                 = "basic"

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags
  )
}

# Create function app for custom api skill for search index.
# FIXME: There is an error with creating a new function app and linking
# to an existing storage account due to networking rules (?), even when
# the terraform client has the roles:
#   - Storage Account Contributor
#   - Storage Blob Data Owner
# Creation of storage file share failed with: 'The remote server returned an error: (403) Forbidden.
# https://stackoverflow.com/questions/67696304/terraform-403-error-when-creating-function-app-and-storage-account-with-private?rq=3
# https://chamindac.blogspot.com/2019/11/resolving-error-there-was-conflict.html
# module "search_service_linux_function_app" {
#   source               = "./modules/linux_function_app"
#   name                 = "${var.environment}-linux-search-function-app"
#   location             = azurerm_resource_group.environment_rg.location
#   resource_group_name  = azurerm_resource_group.environment_rg.name
#   personal_ip_address = var.personal_ip_address

#   tags = merge(
#     var.tags
#   )
# }

# Create container instance pulling the language service image.
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

# Create video indexer service.
module "video_indexer_media_services" {
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
