output "cognitive_services_endpoint" {
  value       = azurerm_cognitive_account.cognitive_services_account.endpoint
  description = <<-EOF
    The endpoint used to connect to the Cognitive Service Account.

EOF
}

output "cognitive_services_primary_access_key" {
  value       = azurerm_cognitive_account.cognitive_services_account.primary_access_key
  description = <<-EOF
    A primary access key which can be used to connect to the Cognitive Service Account.

EOF
  sensitive   = true
}

output "cognitive_services_secondary_access_key" {
  value       = azurerm_cognitive_account.cognitive_services_account.secondary_access_key
  description = <<-EOF
    The secondary access key which can be used to connect to the Cognitive Service Account.

EOF
  sensitive   = true
}
