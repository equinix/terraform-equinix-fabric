data "equinix_fabric_service_profiles" "zside_sp" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_sp_name]
  }
}
data "equinix_fabric_ports" "zside_port" {
  count = var.zside_ap_type == "COLO" ? 1 : 0
  filters {
    name = var.zside_port_name
  }
}
resource "equinix_fabric_connection" "virtual_device_connection" {
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
  bandwidth = var.bandwidth
  redundancy { priority = "PRIMARY" }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }
  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "VD"
      virtual_device {
        type = var.aside_vd_type
        uuid = var.aside_vd_uuid
      }
      dynamic "interface" {
        for_each = var.aside_interface_type != "" ? [1] : []
        content {
          type = var.aside_interface_type != "" ? var.aside_interface_type : null
          id   = var.aside_interface_id != "" ? var.aside_interface_id : null
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
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type   = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region != "" ? var.zside_seller_region : null
        profile{
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
      }
    }
  }

  dynamic "z_side" {
    #Service Token Zside Type
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}

resource "equinix_fabric_connection" "secondary_virtual_device_connection" {
  count = var.secondary_connection_name != "" ? 1 : 0

  name  = var.secondary_connection_name
  type  = var.connection_type
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
  bandwidth = var.secondary_bandwidth
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }

  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "VD"
      virtual_device {
        type = var.aside_vd_type
        uuid = var.aside_vd_uuid
      }
      dynamic "interface" {
        for_each = var.aside_interface_type != "" ? [1] : []
        content {
          type = var.aside_interface_type != "" ? var.aside_interface_type : null
          id   = var.aside_interface_id != "" ? var.aside_interface_id : null
        }
      }
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
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
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
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    #Service Token Zside Type
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}
