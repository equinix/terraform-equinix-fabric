provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_service_profile" "sp-test-1" {
  name           = var.sp_name
  description    = var.sp_description
  type           = "L2_PROFILE"
  visibility     = "PRIVATE"
  allowed_emails = var.allowed_emails
  notifications {
    emails = var.notifications_emails
    type   = "BANDWIDTH_ALERT"
  }
  access_point_type_configs {
    type                             = "COLO"
    connection_redundancy_required   = false
    selective_redundancy             = true
    allow_bandwidth_auto_approval    = false
    allow_remote_connections         = true
    connection_label                 = "private-profile"
    enable_auto_generate_service_key = false
    bandwidth_alert_threshold        = 10
    allow_custom_bandwidth           = true
    supported_bandwidths             = var.supported_bandwidths

    api_config {
      api_available        = false
      equinix_managed_vlan = false
      bandwidth_from_api   = false
      integration_id       = ""
      equinix_managed_port = false
    }

    authentication_key {
      required    = false
      label       = var.authentication_key_label
      description = var.authentication_key_description
    }
  }
  ports {
    type             = "XF_PORT"
    uuid             = var.port_uuid_1
    cross_connect_id = "primary"
  }
  ports {
    type             = "XF_PORT"
    uuid             = var.port_uuid_2
    cross_connect_id = "secondary"
  }
  marketing_info {
    promotion = true
  }
}

data "equinix_fabric_service_profiles" "sp-test" {
  filter {
    property = "/uuid"
    operator = "="
    values   = [equinix_fabric_service_profile.sp-test-1.uuid]
  }
}
#
# module "create_port_2_private_sp_primary_connection" {
#   source = "../../modules/port-connection"
#
#   connection_name       = var.connection_name
#   connection_type       = var.connection_type
#   notifications_type    = var.notifications_type
#   notifications_emails  = var.notifications_emails
#   bandwidth             = var.bandwidth
#   purchase_order_number = var.purchase_order_number
#
#   # A-side
#   aside_port_name = var.aside_port_name_1
#   aside_vlan_tag  = var.aside_vlan_tag
#
#   # Z-side
#   zside_ap_type         = var.zside_ap_type
#   zside_ap_profile_type = var.zside_ap_profile_type
#   zside_location        = var.zside_location
#   zside_sp_uuid         = data.equinix_fabric_service_profiles.sp-test-2.id
# }
#
# module "port_2_private_sp_connection_primary_and_secondary" {
#   source = "../../modules/port-connection"
#
#   connection_name       = var.connection_name
#   connection_type       = var.connection_type
#   notifications_type    = var.notifications_type
#   notifications_emails  = var.notifications_emails
#   bandwidth             = var.bandwidth
#   purchase_order_number = var.purchase_order_number
#
#   # A-side
#   aside_port_name = var.aside_port_name_2_primary
#   aside_vlan_tag  = 348
#
#   # Z-side
#   zside_ap_type         = var.zside_ap_type
#   zside_ap_profile_type = var.zside_ap_profile_type
#   zside_location        = var.zside_location
#   zside_sp_uuid         = data.equinix_fabric_service_profiles.sp-test-2.id
#
#   #Secondary-Connection
#   secondary_connection_name = var.secondary_connection_name
#   secondary_bandwidth       = var.secondary_bandwidth
#   aside_secondary_port_name  = var.aside_port_name_2_secondary
#   aside_secondary_vlan_tag = 917
# }
