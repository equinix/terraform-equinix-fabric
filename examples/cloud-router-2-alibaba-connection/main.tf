provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_fcr_2_alibaba_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name      = var.connection_name
  connection_type      = var.connection_type
  notifications_type   = var.notifications_type
  notifications_emails = var.notifications_emails
  # additional_info       = var.additional_info
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_sp_name
}

module "cloud_router_connection_routing_protocols" {
  source                 = "../../modules/cloud-router-routing-protocols"
  connection_uuid        = module.create_fcr_2_alibaba_connection.primary_connection_id
  direct_rp_name         = var.routing_protocol_direct_rp_name
  direct_equinix_ipv4_ip = var.routing_protocol_direct_ipv4_ip
  bgp_rp_name            = var.routing_protocol_bgp_rp_name
  bgp_customer_peer_ipv4 = var.routing_protocol_bgp_ipv4_ip
  bgp_customer_asn       = var.routing_protocol_bgp_customer_asn
}
