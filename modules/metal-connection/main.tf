data "equinix_fabric_service_profiles" "zside" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_fabric_sp_name]
  }
}
data "equinix_fabric_ports" "zside_port" {
  count = var.zside_ap_type == "COLO" ? 1 : 0
  filters {
    name = var.zside_port_name
  }
}
resource "equinix_fabric_connection" "primary_metal_connection" {
  name = var.connection_name
  type = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  dynamic "project" {
    for_each = var.project_id != "" ? [1] : []
    content {
      project_id = var.project_id
    }
  }
  additional_info = var.additional_info != [] ? var.additional_info : null
  bandwidth       = var.bandwidth
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }
  a_side {
    access_point {
      type               = "METAL_NETWORK"
      authentication_key = var.aside_ap_authentication_key
    }
  }
  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region
        peering_type       = var.zside_peering_type
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside[0].id
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }
  dynamic "z_side" {
    # Port Z_Side Type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside_port[0].data.0.uuid
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }
}
