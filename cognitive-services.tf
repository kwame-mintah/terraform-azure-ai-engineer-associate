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
