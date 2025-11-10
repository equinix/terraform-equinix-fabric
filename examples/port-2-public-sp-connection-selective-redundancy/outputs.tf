output "port_2_public_sp_connection" {
  value = module.create_port_2_public_sp_primary_connection.primary_connection
  sensitive = true
}

output "port_2_public_sp_connection_id" {
  value = module.create_port_2_public_sp_primary_connection.primary_connection_id
}



