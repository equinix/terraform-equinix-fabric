output "route_filter" {
  value = equinix_fabric_route_filter.policy
}

output "route_filter_rule" {
  value = equinix_fabric_route_filter_rule.this
}

output "connection_route_filter" {
  value = equinix_fabric_connection_route_filter.attachment
}
