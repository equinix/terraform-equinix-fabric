output "ibm1_connection" {
  value = module.create_port_2_ibm1_connection.primary_connection
  sensitive = true
}

output "ibm1_connection_id" {
  value = module.create_port_2_ibm1_connection.primary_connection_id
}
