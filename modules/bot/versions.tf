terraform {
  required_version = "= 1.5.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.67.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
}
