output "primary_connection" {
  value = equinix_fabric_connection.primary_cloud_router_connection
}
output "secondary_connection" {
  value = var.secondary_connection_name != "" ? equinix_fabric_connection.secondary_cloud_router_connection[0] : null
}
