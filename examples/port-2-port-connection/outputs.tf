output "port_connection" {
  value = module.create_port_2_port_connection.primary_connection
  sensitive = true
}

output "port_connection_id" {
  value = module.create_port_2_port_connection.primary_connection_id
}
