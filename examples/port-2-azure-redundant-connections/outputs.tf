output "azure_primary_connection" {
  value = module.create_port_2_azure_connections.primary_connection
  sensitive = true
}

output "azure_secondary_connection_id" {
  value = module.create_port_2_azure_connections.secondary_connection
  sensitive = true
}
