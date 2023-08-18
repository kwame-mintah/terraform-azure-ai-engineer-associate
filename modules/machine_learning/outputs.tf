output "machine_learning_workspace_id" {
  value       = azurerm_machine_learning_workspace.machine_learning_workspace.id
  description = <<-EOF
    The ID of the Machine Learning Workspace.

EOF
}

output "machine_learning_workspace_discovery_url" {
  value       = azurerm_machine_learning_workspace.machine_learning_workspace.discovery_url
  description = <<-EOF
    The url for the discovery service to identify regional endpoints 
    for machine learning experimentation services.

EOF
}

output "machine_learning_workspace_workspace_id" {
  value       = azurerm_machine_learning_workspace.machine_learning_workspace.workspace_id
  description = <<-EOF
    The immutable id associated with this workspace.

EOF
}