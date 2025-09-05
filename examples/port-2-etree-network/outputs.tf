output "etree_network" {
  value = equinix_fabric_network.etree_network
}
output "etree_network_id" {
  value = equinix_fabric_network.etree_network.id
}
output "port_connection" {
  value = module.create_port_2_network_connection.primary_connection
  sensitive = true
}
output "port_2_network_connection_id" {
  value = module.create_port_2_network_connection.primary_connection_id
}

