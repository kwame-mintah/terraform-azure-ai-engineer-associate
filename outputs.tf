output "service_principal_client_id" {
  description = <<-EOF
    The principal being used to apply terraform changes 
    for this subscription.

EOF

  value = data.azurerm_client_config.current.client_id
}

output "tenant_id" {
  description = <<-EOF
    The tenant ID used for this subscription.

EOF

  value = data.azurerm_client_config.current.tenant_id
}

output "tfstate_resource_group_name" {
  description = <<-EOF
    The name of the resource group created for the
    Terraform tfstate.

EOF

  value = azurerm_resource_group.environment_rg.name
}

output "tfstate_storage_account_name" {
  description = <<-EOF
    The name of the storage account created for the
    Terraform tfstate.

EOF

  value = azurerm_storage_account.tfstate.name
}

output "tfstate_storage_account_key" {
  description = <<-EOF
    The name of the storage account created for the
    Terraform tfstate.

EOF

  value     = azurerm_storage_account.tfstate.primary_access_key
  sensitive = true
}

output "tfstate_storage_container_name" {
  description = <<-EOF
    The name of the storage container created for the
    Terraform tfstate.

EOF

  value = azurerm_storage_container.tfstate.name
}
