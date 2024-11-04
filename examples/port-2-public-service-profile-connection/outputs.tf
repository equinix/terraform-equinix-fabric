output "public_sp_connection" {
  value = module.create_port_2_public_sp_connection.primary_connection
  sensitive = true
}

output "public_sp_connection_id" {
  value = module.create_port_2_public_sp_connection.primary_connection_id
}
