# (1) This block of code needs to be uncommented out first, before attempting to use the azurerm backend
# After all configurations have been populated run `terragrunt init -migrate-state` in the directory
# When prompted, answer yes and will copy the state file to the storage account.

# terraform {
#   backend "local" {}
# }

# (2) Only uncomment out this code block, after the tfstate storage account has been created
terraform {
  backend "azurerm" {}
}
