output "primary_connection_id" {
  value = equinix_fabric_connection.primary_cloud_router_connection.id
}
output "secondary_connection_id" {
  value = var.secondary_connection_name != "" ? equinix_fabric_connection.secondary_cloud_router_connection[0].id : null
}
