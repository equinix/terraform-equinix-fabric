output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "azure_connection_id" {
  value = module.create_virtual_device_2_azure_connection.primary_connection_id
}
