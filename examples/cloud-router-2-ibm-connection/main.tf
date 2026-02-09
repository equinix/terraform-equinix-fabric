provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

provider "ibm" {
  ibmcloud_api_key      = var.ibm_cloud_api_key
  iaas_classic_username = var.ibm_classic_username
  iaas_classic_api_key  = var.ibm_classic_api_key
}

module "create_fcr_2_ibm2_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
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
  additional_info             = var.additional_info
}

resource "time_sleep" "wait_dl_connection" {
  create_duration = "1m"
}

data "ibm_dl_gateway" "test_ibm_dl_gateway" {
  name       = var.connection_name
  depends_on = [time_sleep.wait_dl_connection]
}

data "ibm_resource_group" "rg" {
  name = var.ibm_resource_group_name
}

resource "ibm_dl_gateway_action" "test_dl_gateway_action" {
  gateway        = data.ibm_dl_gateway.test_ibm_dl_gateway.id
  action         = var.ibm_gateway_action
  global         = var.ibm_gateway_global
  metered        = var.ibm_gateway_metered
  resource_group = data.ibm_resource_group.rg.id
}

resource "time_sleep" "wait_provider_approval" {
  depends_on      = [module.create_fcr_2_ibm2_connection]
  create_duration = "4m"
}

module "cloud_router_connection_routing_protocols" {
  source                 = "../../modules/cloud-router-routing-protocols"
  depends_on             = [resource.time_sleep.wait_dl_connection, data.ibm_dl_gateway.test_ibm_dl_gateway, data.ibm_resource_group.rg, resource.ibm_dl_gateway_action.test_dl_gateway_action, resource.time_sleep.wait_provider_approval]
  connection_uuid        = module.create_fcr_2_ibm2_connection.primary_connection_id
  direct_rp_name         = var.routing_protocol_direct_rp_name
  direct_equinix_ipv4_ip = var.routing_protocol_direct_ipv4_ip
  bgp_rp_name            = var.routing_protocol_bgp_rp_name
  bgp_customer_peer_ipv4 = var.routing_protocol_bgp_ipv4_ip
  bgp_customer_asn       = var.routing_protocol_bgp_customer_asn
}
