resource "equinix_fabric_route_aggregation" "route-aggregation" {
  type        = var.route_aggregation_type
  name        = var.route_aggregation_name
  description = var.route_aggregation_description
  project = {
    project_id = var.route_aggregation_project_id
  }
}

resource "equinix_fabric_route_aggregation_rule" "ra_rule" {
  route_aggregation_id  = equinix_fabric_route_aggregation.route-aggregation.id
  name                  = var.route_aggregation_rule_name
  description           = var.route_aggregation_rule_description
  prefix                = var.route_aggregation_rule_prefix
}

resource "equinix_fabric_connection_route_aggregation" "attachment" {
  route_aggregation_id  = equinix_fabric_route_aggregation.route-aggregation.id
  connection_id         = var.connection_id
}
