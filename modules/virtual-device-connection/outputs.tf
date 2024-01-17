output "primary_connection_id" {
  value = equinix_fabric_connection.virtual_device_connection.id
}
output "secondary_connection_id" {
  value = var.secondary_connection_name != "" ? equinix_fabric_connection.secondary_virtual_device_connection[0].id : null
}
