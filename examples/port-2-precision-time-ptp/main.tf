provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_port_2_precision_time_ptp_service_profile" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}

resource "equinix_fabric_precision_time" "ptp" {
  type = "PTP"
  name = var.precision_time_ptp_name
  description = var.precision_time_ptp_description
  package {
    code = var.precision_time_ptp_package_code
  }
  connections {
    uuid = module.create_port_2_precision_time_ptp_service_profile.primary_connection_id
  }
  ipv4 {
    primary = var.precision_time_ptp_ipv4_primary
    secondary = var.precision_time_ptp_ipv4_secondary
    network_mask = var.precision_time_ptp_ipv4_network_mask
    default_gateway = var.precision_time_ptp_ipv4_default_gateway
  }
  dynamic "advance_configuration" {
    for_each = (
      var.precision_time_advance_configuration_ptp_timescale != null ||
      var.precision_time_advance_configuration_ptp_domain != null ||
      var.precision_time_advance_configuration_ptp_priority_1 != null ||
      var.precision_time_advance_configuration_ptp_priority_2 != null ||
      var.precision_time_advance_configuration_ptp_log_announce_interval != null ||
      var.precision_time_advance_configuration_ptp_log_sync_interval != null ||
      var.precision_time_advance_configuration_ptp_log_delay_req_interval != null ||
      var.precision_time_advance_configuration_ptp_transport_mode != null ||
      var.precision_time_advance_configuration_ptp_grant_time != null ?
      [1] : []
    )
    content {
      ptp {
        time_scale = var.precision_time_advance_configuration_ptp_timescale
        domain = var.precision_time_advance_configuration_ptp_domain
        priority_1 = var.precision_time_advance_configuration_ptp_priority_1
        priority_2 = var.precision_time_advance_configuration_ptp_priority_2
        log_announce_interval = var.precision_time_advance_configuration_ptp_log_announce_interval
        log_sync_interval = var.precision_time_advance_configuration_ptp_log_sync_interval
        log_delay_req_interval = var.precision_time_advance_configuration_ptp_log_delay_req_interval
        transport_mode = var.precision_time_advance_configuration_ptp_transport_mode
        grant_time = var.precision_time_advance_configuration_ptp_grant_time
      }
    }
  }
}
