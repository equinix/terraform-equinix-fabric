output "fabric_connection" {
  value = module.create_virtual_device_2_service_token_connection.primary_connection
  sensitive = true
}
