output "vd_2_network_connection" {
  value = module.create_virtual_device_2_network_connection.primary_connection
  sensitive = true
}

output "vd_2_network_connection_id" {
  value = module.create_virtual_device_2_network_connection.primary_connection_id
}
