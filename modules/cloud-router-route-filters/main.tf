resource "equinix_fabric_route_filter" "policy" {
  name = var.route_filter_policy_name
  project {
    project_id = var.route_filter_policy_project_id
  }
  type = var.route_filter_policy_type
  description = var.route_filter_policy_description != "" ? var.route_filter_policy_description : null
}

resource "equinix_fabric_route_filter_rule" "this" {
  for_each = {
    for index, rule in var.route_filter_rules:
        rule.prefix => rule
  }
  route_filter_id = equinix_fabric_route_filter.policy.id
  name = each.value.name != "" ? each.value.name : null
  description = each.value.description != "" ? each.value.description : null
  prefix = each.value.prefix
  prefix_match = each.value.prefix_match != "" ? each.value.prefix_match : null
}


resource "equinix_fabric_connection_route_filter" "attachment" {
  depends_on = [ equinix_fabric_route_filter_rule.this ]
  connection_id = var.connection_id
  route_filter_id = equinix_fabric_route_filter.policy.id
  direction = var.connection_route_filter_direction
}

