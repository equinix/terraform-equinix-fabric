output "direct_rp" {
  value = module.routing_protocols.direct_routing_protocol
  sensitive = true
}

output "bgp_rp" {
  value = module.routing_protocols.bgp_routing_protocol
  sensitive = true
}

output "direct_rp_id" {
  value = module.routing_protocols.direct_routing_protocol_id
}

output "bgp_rp_id" {
  value = module.routing_protocols.bgp_routing_protocol_id
}
