output "eia_connection" {
  value = module.create_virtual_device_2_eia_connection.primary_connection
  sensitive = true
}

output "eia_connection_id" {
  value = module.create_virtual_device_2_eia_connection.primary_connection_id
}
