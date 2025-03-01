output "port_connection" {
  value = module.cloud_router_port_connection.primary_connection
  sensitive = true
}

output "port_connection_id" {
  value = module.cloud_router_port_connection.primary_connection_id
}

output "route_aggrgeation_id" {
  value = module.cloud_router_route_aggregation.route_aggregation.id
}

output "route_aggregation_rule_id" {
  value = module.cloud_router_route_aggregation.route_aggregation_rule.id
}

output "route_aggregation_connection_attachment_id" {
  value = module.cloud_router_route_aggregation.connection_route_aggregation.id
}
