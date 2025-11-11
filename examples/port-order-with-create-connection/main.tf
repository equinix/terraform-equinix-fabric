provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_port" "order" {
  type = "XF_PORT"
  physical_ports_speed = var.physical_ports_speed
  connectivity_source_type = var.connectivity_source_type
  project = {
    project_id = var.project_id
  }
  account = {
    account_number = var.account_number
  }
  location = {
    metro_code = var.metro_code
  }
  physical_ports_type = var.physical_ports_type
  demarcation_point_ibx = var.demarcation_point_ibx
  redundancy = {
    priority = var.priority
  }
  encapsulation = {
    type = var.encapsulation_type
    tag_protocol_id = var.tag_protocol_id
  }
  lag_enabled = var.lag_enabled
  settings = {
    package_type = var.package_type
    shared_port_type = var.shared_port_type
  }
  physical_ports = [
    {
      type = var.type
      demarcation_point = {
        cage_unique_space_id = var.cage_unique_space_id
        cabinet_unique_space_id = var.cabinet_unique_space_id
        connector_type = var.connector_type
        patch_panel = var.patch_panel
        ibx = var.ibx
      }
    }
  ]
  notifications = [
    {
      type = "TECHNICAL"
      registered_users = [
        var.registered_user
      ]
    },
    {
      type = "NOTIFICATION"
      registered_users = [
        var.registered_user
      ]
    }
  ]
  physical_ports_count = var.physical_ports_count
}

resource "time_sleep" "wait_for_activation" {
  depends_on      = [equinix_fabric_port.order]
  create_duration = "5m"
}

data "equinix_fabric_port" "check_active" {
  depends_on = [time_sleep.wait_for_activation]
  uuid       = equinix_fabric_port.order.id
}

resource "null_resource" "port_active_check" {
  depends_on = [data.equinix_fabric_port.check_active]

  lifecycle {
    precondition {
      condition     = data.equinix_fabric_port.check_active.state == "ACTIVE"
      error_message = "Port must be ACTIVE (current: ${data.equinix_fabric_port.check_active.state})"
    }
  }
}

module "create_port_2_public_sp_connection" {
  depends_on = [null_resource.port_active_check]
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_uuid = equinix_fabric_port.order.id
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}
