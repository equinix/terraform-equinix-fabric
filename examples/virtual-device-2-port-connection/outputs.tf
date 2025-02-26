output "vd_2_port_connection" {
  value = module.create_virtual_device_2_port_connection.primary_connection
  sensitive = true
}

output "vd_2_port_connection_id" {
  value = module.create_virtual_device_2_port_connection.primary_connection_id
}
