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

module "cloud_router_azure_redundant_connection" {
  source = "../../modules/cloud-router-connection"

  #Primary Connection
  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_type  = var.aside_ap_type
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_fabric_sp_name        = var.zside_fabric_sp_name
  zside_peering_type          = var.zside_peering_type

  #Secondary-Connection
  secondary_connection_name       = var.secondary_connection_name
  secondary_bandwidth             = var.secondary_bandwidth
  aside_sec_fcr_uuid              = var.aside_sec_fcr_uuid
}