output "direct_routing_protocol" {
  value = equinix_fabric_routing_protocol.direct
}

output "bgp_routing_protocol" {
  value = var.bgp_rp_name != "" ? equinix_fabric_routing_protocol.bgp[0] : null
}
