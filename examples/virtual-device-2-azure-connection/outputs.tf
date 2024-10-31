output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "azure_connection" {
  value = module.create_virtual_device_2_azure_connection.primary_connection
}
