

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "random_integer" "random_vlan_tag" {
  min = 50
  max = 2549
}

output "random_vlan_tag" {
  value = random_integer.random_vlan_tag.result
}

module "create_port_2_precision_time_ptp_service_profile" {
  source = "../../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = tostring(random_integer.random_vlan_tag.result)

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}

resource "equinix_fabric_precision_time_service" "ptp" {
  type = "PTP"
  name = var.precision_time_ptp_name
  package = {
    code = var.precision_time_ptp_package_code
  }
  connections = [
    {
      uuid = module.create_port_2_precision_time_ptp_service_profile.primary_connection_id
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