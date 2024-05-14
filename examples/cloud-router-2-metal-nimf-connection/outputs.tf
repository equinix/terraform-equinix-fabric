output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "cloud_router_metal_connection_id" {
  value = module.cloud_router_2_metal_connection.primary_connection_id
}
