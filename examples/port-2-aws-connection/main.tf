terraform {
  required_providers {
    equinix = {
      source="equinix/equinix"
    }
  }
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_aws_connection" {
  source = "../../modules/port-2-aws"

  connection_name = var.connection_name
  connection_type = var.connection_type
  notifications_type = var.notifications_type
  notifications_emails = var.notifications_emails
  bandwidth = var.bandwidth
  redundancy = var.redundancy
  purchase_order_number = var.purchase_order_number
  aside_ap_type = var.aside_ap_type
  aside_link_protocol_type = var.aside_link_protocol_type
  aside_link_protocol_stag = var.aside_link_protocol_stag
  aside_link_protocol_ctag = var.aside_link_protocol_ctag
  zside_ap_type = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location = var.zside_location
  seller_region = var.seller_region
  fabric_sp_name = var.fabric_sp_name
  equinix_port_name = var.equinix_port_name
}