provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_port" "order" {
  type = "XF_PORT"
  connectivity_source_type = "COLO"
  location = {
    metro_code = "TR"
  }
  settings = {
    package_type = "STANDARD"
    shared_port_type = false
  }
  encapsulation = {
    type = "DOT1Q"
    tag_protocol_id = "0x8100"
  }
  account = {
    account_number = "200552"
  }
  project = {
    project_id = "333cd592-1709-4238-bb0d-2c2b41896aa1"
  }
  redundancy = {
    priority = "PRIMARY"
  }
  lag_enabled = true
  physical_ports = [
    {
      type = "XF_PHYSICAL_PORT"
      demarcation_point = {
        ibx = "TR2"
        cage_unique_space_id = "TR2:01:002087"
        cabinet_unique_space_id = "Demarc"
        patch_panel = "PP:Demarc:00002087"
        connector_type = "SC"
      }
    }
  ]
  physical_ports_speed = 1000
  physical_ports_type = "1000BASE_LX"
  physical_ports_count = 1
  demarcation_point_ibx = "TR2"
  notifications = [
    {
      type = "TECHNICAL"
      registered_users = [
        "jaguarsuser-port-order"
      ]
    },
    {
      type = "NOTIFICATION"
      registered_users = [
        "jaguarsuser-port-order"
      ]
    }
  ]
  additional_info = [
    {
      key = "InterfaceReferenceId"
      value = ""
    },
    {
      key = "lagType"
      value = "New"
    }
  ]
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
  aside_port_name = equinix_fabric_port.order.name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}
