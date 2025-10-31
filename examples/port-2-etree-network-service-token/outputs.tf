output "etree_network" {
  value = equinix_fabric_network.etree_network
}
output "etree_network_id" {
  value = equinix_fabric_network.etree_network.id
}
output "service_token_id" {
  value = equinix_fabric_service_token.service-token.id
}
output "service-token" {
  value = equinix_fabric_service_token.service-token
}
output "port_connection" {
  value = module.port_2_network_service_token_connection_id.primary_connection
  sensitive = true
}
output "port_2_network_service_token_connection_id" {
  value = module.port_2_network_service_token_connection_id.primary_connection_id
}
