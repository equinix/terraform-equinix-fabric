provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_port_connection" {
  source = "../../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type   = var.zside_ap_type
  zside_location  = var.zside_location
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
}

module "routing_protocols" {
  depends_on = [module.cloud_router_port_connection]
  source = "../../../modules/cloud-router-routing-protocols"

  connection_uuid = module.cloud_router_port_connection.primary_connection_id

  # Direct RP Details
  direct_rp_name         = var.direct_rp_name
  direct_equinix_ipv4_ip = var.direct_equinix_ipv4_ip
  direct_equinix_ipv6_ip = var.direct_equinix_ipv6_ip

  # BGP RP Details
  bgp_rp_name            = var.bgp_rp_name
  bgp_customer_asn       = var.bgp_customer_asn
  bgp_customer_peer_ipv4 = var.bgp_customer_peer_ipv4
  bgp_enabled_ipv4       = var.bgp_enabled_ipv4
  bgp_customer_peer_ipv6 = var.bgp_customer_peer_ipv6
  bgp_enabled_ipv6       = var.bgp_enabled_ipv6
}

module "cloud_router_route_filters" {
  depends_on = [ module.routing_protocols ]
  source                            = "../../../modules/cloud-router-route-filters"
  connection_id                     = module.cloud_router_port_connection.primary_connection_id
  connection_route_filter_direction = var.route_filter_direction

  route_filter_policy_name       = var.route_filter_policy_name
  route_filter_policy_project_id = var.project_id
  route_filter_policy_type       = var.route_filter_policy_type

  route_filter_rules = var.route_filter_rules
}
