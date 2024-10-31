output "primary_connection" {
  value = equinix_fabric_connection.primary_port_connection
}

output "secondary_connection" {
  value = var.aside_secondary_port_name != "" ? equinix_fabric_connection.secondary_port_connection[0] : null
}
