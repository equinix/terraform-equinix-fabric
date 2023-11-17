terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ""
    }
  }
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_port_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  additional_info       = [{ key = "accessKey", value = var.access_key }, { key = "secretKey", value = var.secret_key }]
  bandwidth             = var.bandwidth
  redundancy            = var.redundancy
  purchase_order_number = var.purchase_order_number

  #Aside
  fcr_uuid      = var.fcr_uuid
  aside_ap_type = var.aside_ap_type

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  seller_region               = var.seller_region
  fabric_sp_name              = var.fabric_sp_name
  zside_port_name             = var.zside_port_name
  zside_vlan_tag              = var.zside_vlan_tag
  zside_link_protocol_type    = var.zside_link_protocol_type
}