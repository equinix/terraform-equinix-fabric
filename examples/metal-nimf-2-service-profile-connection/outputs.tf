output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "metal_service_profile_connection" {
  value = module.metal_2_service_profile.primary_connection
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
