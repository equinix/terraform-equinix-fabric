output "primary_connection" {
  value = equinix_fabric_connection.primary_metal_connection
}

output "primary_connection_id" {
  value = equinix_fabric_connection.primary_metal_connection.id
}
