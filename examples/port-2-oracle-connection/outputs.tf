output "oracle_connection" {
  value = module.create_port_2_oracle_connection.primary_connection
  sensitive = true
}

output "oracle_connection_id" {
  value = module.create_port_2_oracle_connection.primary_connection_id
}
