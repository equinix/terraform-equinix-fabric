provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_port" "order" {
  type = "XF_PORT"
  name = var.port_name
  physical_ports_speed = var.physical_ports_speed
  connectivity_source_type = "COLO"
  project = {
    project_id = var.project_id
  }
  order = {
    purchase_order = var.purchase_order_number
  }
  account = {
    account_number = var.account_number
  }
  location = {
    region     = "AMER"
    metro_name = "Silicon Valley"
    metro_code = var.metro_code
    ibx = var.ibx
  }
  physical_ports_type = var.physical_ports_type
  demarcation_point_ibx = var.demarcation_point_ibx
  redundancy = {
    priority = "PRIMARY"
  }
  encapsulation = {
    type = "DOT1Q"
    tag_protocol_id = "0x8100"
  }
  lag_enabled = false
  settings = {
    package_type = "STANDARD"
    shared_port_type = false
  }
  physical_ports = [
    {
      type = "XF_PHYSICAL_PORT"
      id = var.physical_port_id
      state = "PROVISIONED"
      bandwidth = 0
      uuid = var.physical_port_id
      demarcation_point = {
        cage_unique_space_id = var.cage_unique_space_id
        cabinet_unique_space_id = var.cabinet_unique_space_id
        connector_type = "SC"
        patch_panel = var.patch_panel
        patch_panel_name = var.patch_panel_name
        patch_panel_portA = var.patch_panel_portA
        patch_panel_portB = var.patch_panel_portB
        ibx = "SV5"
      }
      settings = {
        shared_port_type = "NA"
        shared_port_product = "NA"
        package_type = "STANDARD"
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
  physical_ports_count = 1
}

module "create_port_2_public_sp_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_uuid = var.aside_port_uuid
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}
