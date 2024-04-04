output "port_connection_id" {
  value = module.cloud_router_port_connection.primary_connection_id
}
output "direct_rp_id" {
  value = module.routing_protocols.direct_routing_protocol_id
}

output "bgp_rp_id" {
  value = module.routing_protocols.bgp_routing_protocol_id
}
