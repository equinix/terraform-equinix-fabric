provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_virtual_device_redundant_connection" {
  source = "../../modules/cloud-router-connection"

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
  zside_ap_type        = var.zside_ap_type
  zside_vd_type        = var.zside_vd_type
  zside_vd_uuid        = var.zside_vd_uuid
  zside_interface_type = var.zside_interface_type
  zside_interface_id   = var.zside_interface_id

  #Secondary-Connection
  secondary_connection_name = var.secondary_connection_name
  secondary_bandwidth       = var.secondary_bandwidth
  zside_sec_vd_uuid         = var.zside_sec_vd_uuid
  zside_sec_interface_type  = var.zside_sec_interface_type
  zside_sec_interface_id    = var.zside_sec_interface_id
}
