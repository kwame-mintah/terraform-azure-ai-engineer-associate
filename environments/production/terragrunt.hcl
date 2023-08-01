# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../.."
}

locals {
  environment = "prod"
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  tags = {
    Terraform = "true"
    Environment = "${local.environment}"
  }
}