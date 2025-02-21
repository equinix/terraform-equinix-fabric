output "azure_connection" {
  value = module.create_virtual_device_2_azure_connection.primary_connection
  sensitive = true
}

output "azure_connection_id" {
  value = module.create_virtual_device_2_azure_connection.primary_connection_id
}
