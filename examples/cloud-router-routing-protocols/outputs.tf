output "direct_rp" {
  value = module.routing_protocols.direct_routing_protocol
  sensitive = true
}

output "bgp_rp_id" {
  value = module.routing_protocols.bgp_routing_protocol
  sensitive = true
}
