output "linux_function_app_id" {
  value       = azurerm_linux_function_app.linux_function_app.id
  description = <<-EOF
    The ID of the Linux Function App.

EOF
}
