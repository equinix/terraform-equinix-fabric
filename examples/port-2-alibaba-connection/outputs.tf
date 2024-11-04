output "alibaba_connection" {
  value = module.create_port_2_alibaba_connection.primary_connection
  sensitive = true
}

output "alibaba_connection_id" {
  value = module.create_port_2_alibaba_connection.primary_connection_id
}
