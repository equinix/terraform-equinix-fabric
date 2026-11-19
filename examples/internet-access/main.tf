provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "internet_access" {
  source = "../../modules/internet-access"

  name                   = var.name
  type                   = var.type
  project_id             = var.project_id
  account_number         = var.account_number
  billing_type           = var.billing_type
  bandwidth              = var.bandwidth
  purchase_order_number  = var.purchase_order_number
  routing_protocol_type  = var.routing_protocol_type
  port_uuid              = var.port_uuid
  service_profile_uuid   = var.service_profile_uuid
  metro_code             = var.metro_code
  connection_name        = var.connection_name
  connection_type        = var.connection_type
  connection_bandwidth   = var.connection_bandwidth
  notifications_emails   = var.notifications_emails
  zside_ap_type          = var.zside_ap_type
  zside_ap_profile_type  = var.zside_ap_profile_type
  ip_block_type          = var.ip_block_type
  ip_block_prefix_length = var.ip_block_prefix_length
  asn_uuid               = var.asn_uuid
  customer_asn           = var.customer_asn
  customer_asn_range     = var.customer_asn_range
  bgp_auth_key           = var.bgp_auth_key
  export_policy          = var.export_policy
}
