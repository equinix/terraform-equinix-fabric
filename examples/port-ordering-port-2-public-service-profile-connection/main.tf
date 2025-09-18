provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_port" "order" {
  physical_ports_type = "1000BASE_LX"
  type = "XF_PORT"
  name = "panthers-CX-SV5-NL-Dot1q-STD-1G-PRI-JP-170"
  physical_ports_speed = 1000
  connectivity_source_type = "COLO"
  project = {
    project_id = "33ec651f-cc99-48e0-94d3-47466899cdc7"
  }
  order = {
    purchase_order = ""
  }
  account = {
    account_number = 201257
    org_id = 91955
    organization_name = "ops-user100-201257."
    ucm_id = "CF9FFD1D-2B19-42cb-B05C-AA9D46B7AA0F"
    global_cust_id = "0017i000011X2MVAA0"
  }
  location = {
    region     = "AMER"
    metro_name = "Silicon Valley"
    metro_code = "SV"
    ibx = "SV5"
  }

  demarcation_point_ibx = "SV5"
  redundancy = {
    priority = "PRIMARY"
  }
  encapsulation = {
    type = "DOT1Q"
    tag_protocol_id = "0x8100"
  }
  lag_enabled = false
  settings = {
    buyout = false
    view_port_permission = true
    place_vc_order_permission = true
    product_code = "CX"
    product_part = "ECX00001.PROD"
    package_type = "STANDARD"
    shared_port_type = false
  }
  physical_ports = [
    {
      interface = {
        name = "ge-1/2/8"
      }
      type = "XF_PHYSICAL_PORT"
      id = 1359471
      state = "PROVISIONED"
      bandwidth = 0
      uuid = "01892489-ce07-7962-b32e-092404043fa1"
      tether = {
        cross_connect_id = "ECX.03.00000850"
        cabinet_number = "Demarc"
        system_name = "SV5:01:003033"
        patch_panel = " "
        ibx = "SV5"
      }
      demarcation_point = {
        cage_unique_space_id = "SV5:01:003033"
        cabinet_unique_space_id = "Demarc"
        connector_type = "SC"
        patch_panel = "PP:Demarc:00003033"
        patch_panel_name = "PP:Demarc:00003033"
        patch_panel_portA = "13"
        patch_panel_portB = "14"
        ibx = "SV5"
      }
      settings = {
        shared_port_type = "NA"
        shared_port_product = "NA"
        package_type = "STANDARD"
      }
      operation = {
        operational_status = "UP"
      }
    }
  ]
  notifications = [
    {
      type = "TECHNICAL"
      registered_users = [
        "panthersfcr"
      ]
    },
    {
      type = "NOTIFICATION"
      registered_users = [
        "panthersfcr"
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
