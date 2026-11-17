provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vlan_tag" {
  source = "../../modules/random-vlan-tag"
  count  = var.create ? 1 : 0
}

module "ia_connection" {
  source = "../../modules/port-connection"
  count  = var.create ? 1 : 0

  connection_name       = var.connection_name
  connection_type       = "IA_VC"
  project_id            = var.project_id
  bandwidth             = var.connection_bandwidth
  notifications_emails  = var.notifications_emails
  aside_port_uuid       = var.port_uuid
  aside_vlan_tag        = module.vlan_tag[0].result_string
  aside_location        = var.metro_code
  zside_ap_type         = "SP"
  zside_ap_profile_type = "IA_PROFILE"
  zside_sp_uuid         = var.service_profile_uuid
  zside_location        = var.metro_code
}

module "ip_block" {
  source = "../../modules/ip-block"
  count  = var.create ? 1 : 0

  project_id          = var.project_id
  prefix_length       = var.ip_block_prefix_length
  location_metro_code = var.metro_code
  account_number      = var.account_number
}

module "internet_access" {
  source = "../../modules/internet-access"

  create = var.create

  name                  = var.name
  type                  = var.type
  project_id            = var.project_id
  account_number        = var.account_number
  billing_type          = var.billing_type
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  routing_protocol_type = var.routing_protocol_type
  connection_uuids      = var.create ? [module.ia_connection[0].primary_connection.uuid] : []

  asn_uuid           = var.asn_uuid
  customer_asn       = var.customer_asn
  customer_asn_range = var.customer_asn_range
  bgp_auth_key       = var.bgp_auth_key
  export_policy      = var.export_policy

  customer_route_ip_block_uuids = var.create ? [module.ip_block[0].uuid] : []
}

