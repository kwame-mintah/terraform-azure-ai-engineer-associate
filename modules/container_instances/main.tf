# Container Instances Module ---------------------
# -----------------------------------------------

locals {
  common_tags = merge(
    var.tags
  )
}

# Creates an Azure Container Group instance for Cognitive Services, with specified attributes including the name, location, 
# resource group, IP address type, OS type, DNS label, and associated container settings. It includes container-specific details 
# like image, CPU, memory, environment variables, secure environment variables, ports, and restart policy, along with merged tags.
resource "azurerm_container_group" "cognitive_service_container_instance" {
  name                        = "${var.environment}-${var.name}-container-instance"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  ip_address_type             = "Public"
  os_type                     = "Linux"
  dns_name_label              = "${var.name}-dns-label"
  dns_name_label_reuse_policy = "SubscriptionReuse"

  container {
    name   = "${var.name}-containerapp"
    image  = var.image
    cpu    = "1"
    memory = "4"

    environment_variables = {
      "Eula" = "accept"
    }

    secure_environment_variables = {
      "Billing" = var.cognitive_service_endpoint
      "ApiKey"  = var.cognitive_service_api_key
    }

    ports {
      port     = 5000
      protocol = "TCP"
    }

    commands = []
  }

  restart_policy = "OnFailure"

  tags = merge(
    local.common_tags
  )
}
