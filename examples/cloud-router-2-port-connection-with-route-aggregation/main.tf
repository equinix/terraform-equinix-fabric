provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_cloud_router" "this" {
  type = var.cloud_router_type
  name = var.cloud_router_name
  location {
    metro_code = var.cloud_router_metro_code
  }
  package {
    code = var.cloud_router_package
  }
  order {
    purchase_order_number = var.purchase_order_number
  }
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
  account {
    account_number = var.account_number
  }
}

module "cloud_router_port_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  project_id            = var.project_id

  #Aside
  aside_fcr_uuid = equinix_fabric_cloud_router.this.id

  #Zside
  zside_ap_type   = var.zside_ap_type
  zside_location  = var.zside_location
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
}

module "cloud_router_connection_routing_protocols" {
  source = "../../modules/cloud-router-routing-protocols"
  connection_uuid = module.cloud_router_port_connection.primary_connection_id
  direct_rp_name = var.routing_protocol_direct_rp_name
  direct_equinix_ipv4_ip = var.routing_protocol_direct_ipv4_ip
  bgp_rp_name = var.routing_protocol_bgp_rp_name
  bgp_customer_peer_ipv4 = var.routing_protocol_bgp_ipv4_ip
  bgp_customer_asn = var.routing_protocol_bgp_customer_asn
}

module "cloud_router_route_aggregation" {
  depends_on = [ module.cloud_router_connection_routing_protocols ]
  source                            = "../../modules/cloud-router-route-aggregations"
  route_aggregation_type            = var.route_aggregation_type
  route_aggregation_name            = var.route_aggregation_name
  route_aggregation_description     = var.route_aggregation_description

  route_aggregation_project_id = var.project_id
  route_aggregation_rule_name = var.route_aggregation_rule_name
  route_aggregation_rule_description = var.route_aggregation_rule_description
  route_aggregation_rule_prefix = var.route_aggregation_rule_prefix

  connection_id                     = module.cloud_router_port_connection.primary_connection_id
}
