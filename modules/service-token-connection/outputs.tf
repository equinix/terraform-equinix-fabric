output "primary_connection" {
  value = equinix_fabric_connection.service_token_connection
}

output "primary_connection_id" {
  value = equinix_fabric_connection.service_token_connection.id
}
