provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_virtual_device_2_wan_connection" {
  source = "../../../modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type         = var.aside_vd_type
  aside_vd_uuid         = var.aside_vd_uuid
  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_network_uuid          = var.zside_network_uuid
}
