output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "cloud_router_metal_connection" {
  value = module.cloud_router_2_metal_connection.primary_connection
}
output "cloud_router_routing_protocol" {
  value = module.routing_protocols.direct_routing_protocol
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
