# Create machine learning resources.
module "machine_learning" {
  source              = "./modules/machine_learning"
  name                = "machine-learning"
  location            = azurerm_resource_group.environment_rg.location
  resource_group_name = azurerm_resource_group.environment_rg.name
  environment         = var.environment
  personal_ip_address = var.personal_ip_address

  tags = merge(
    local.common_tags
  )
}
