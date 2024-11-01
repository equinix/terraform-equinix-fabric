output "eia_connection" {
  value = module.create_virtual_device_2_azure_connection.primary_connection
  sensitive = true
}
