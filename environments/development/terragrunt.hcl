# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../.."
}

locals {
  environment = "dev"
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  tags = {
    Terraform   = "true"
    Environment = "${local.environment}"
    Pathway     = "AI-102"
  }
  environment = "development"
}

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }
}