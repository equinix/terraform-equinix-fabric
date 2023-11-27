output "primary_connection_id" {
  value = equinix_fabric_connection.primary_port_connection.id
}

output "secondary_connection_id" {
  value = var.aside_secondary_port_name != "" ? equinix_fabric_connection.secondary_port_connection[0].id : null
}
