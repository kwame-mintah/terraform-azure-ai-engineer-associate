output "media_services_account_id" {
  value       = azurerm_media_services_account.media_services.id
  description = <<-EOF
    The ID of the Media Services Account.

EOF
}
