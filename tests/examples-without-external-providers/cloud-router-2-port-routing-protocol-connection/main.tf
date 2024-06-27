provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  endpoint = "https://uatapi.equinix.com"
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
  source = "../../../modules/routing-protocols"

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
