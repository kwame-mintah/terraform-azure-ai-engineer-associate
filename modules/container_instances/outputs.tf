output "cognitive_service_instance_fdqn" {
  value       = azurerm_container_group.cognitive_service_container_instance.fqdn
  description = <<-EOF
    The FQDN of the container group derived from `dns_name_label`.

EOF
}
