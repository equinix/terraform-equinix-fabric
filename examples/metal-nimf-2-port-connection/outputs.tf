output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "metal_port_connection_id" {
  value = module.metal_2_port_connection.primary_connection_id
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
