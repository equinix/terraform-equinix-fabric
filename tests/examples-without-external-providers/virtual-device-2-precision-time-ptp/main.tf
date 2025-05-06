provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_virtual_device_2_precision_time_ptp" {
  source = "../../../modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = var.aside_vd_uuid

  # Z-side
  zside_ap_type   = var.zside_ap_type
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
  zside_location  = var.zside_location
}

resource "equinix_fabric_precision_time_service" "ptp" {
  type = "PTP"
  name = var.precision_time_ptp_name
  package = {
    code = var.precision_time_ptp_package_code
  }
  connections = [
    {
      uuid = module.create_virtual_device_2_precision_time_ptp.primary_connection_id
    }
  ]
  ipv4 = {
    primary         = var.precision_time_ptp_ipv4_primary
    secondary       = var.precision_time_ptp_ipv4_secondary
    network_mask    = var.precision_time_ptp_ipv4_network_mask
    default_gateway = var.precision_time_ptp_ipv4_default_gateway
  }
  ptp_advanced_configuration = var.precision_time_ptp_advance_configuration != null ? var.precision_time_ptp_advance_configuration : null
}