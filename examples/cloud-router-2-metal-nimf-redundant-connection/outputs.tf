output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "cloud_router_metal_primary_connection_id" {
  value = module.cloud_router_2_metal_connection.primary_connection_id
}
output "primary_connection_cloud_router_routing_protocol_id" {
  value = module.primary_connection_routing_protocols.direct_routing_protocol_id
}
output "secondary_connection_cloud_router_routing_protocol_id" {
  value = module.secondary_connection_routing_protocols.direct_routing_protocol_id
}
