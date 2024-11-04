output "azure_connection" {
  value = module.create_port_2_azure_connection.primary_connection
  sensitive = true
}

output "azure_connection_id" {
  value = module.create_port_2_azure_connection.primary_connection_id
}
