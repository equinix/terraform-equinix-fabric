output "direct_routing_protocol" {
  value = equinix_fabric_routing_protocol.direct
}

output "bgp_routing_protocol" {
  value = var.bgp_rp_name != "" ? equinix_fabric_routing_protocol.bgp[0] : null
}

output "direct_routing_protocol_id" {
  value = equinix_fabric_routing_protocol.direct.id
}

output "bgp_routing_protocol_id" {
  value = var.bgp_rp_name != "" ? equinix_fabric_routing_protocol.bgp[0].id : null
}
