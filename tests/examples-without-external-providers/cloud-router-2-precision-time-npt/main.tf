provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_cloud_router_2_precision_time_ntp" {
  source               = "../../../modules/cloud-router-connection"
  connection_name      = var.connection_name
  connection_type      = var.connection_type
  notifications_type   = var.notifications_type
  notifications_emails = var.notifications_emails
  bandwidth            = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_fcr_uuid = var.aside_fcr_uuid

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_fabric_sp_name  = var.zside_fabric_sp_name
}

resource "equinix_fabric_precision_time_service" "ntp" {
  type = "NTP"
  name = var.precision_time_ntp_name
  package = {
    code = var.precision_time_ntp_package_code
  }
  connections = [
    {
      uuid = module.create_cloud_router_2_precision_time_ntp.primary_connection_id
    }
  ]
  ipv4 = {
    primary         = var.precision_time_ntp_ipv4_primary
    secondary       = var.precision_time_ntp_ipv4_secondary
    network_mask    = var.precision_time_ntp_ipv4_network_mask
    default_gateway = var.precision_time_ntp_ipv4_default_gateway
  }
  ntp_advanced_configuration = var.precision_time_ntp_advance_configuration != null ? var.precision_time_ntp_advance_configuration : null
}
