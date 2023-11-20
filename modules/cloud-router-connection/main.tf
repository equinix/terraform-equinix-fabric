terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ""
    }
  }
}

data "equinix_fabric_service_profiles" "zside" {
    count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_fabric_sp_name]
  }
}
data "equinix_fabric_ports" "zside" {
    count  = var.zside_ap_type == "COLO" ? 1 : 0
  filters {
    name   = var.zside_port_name
  }
}


resource "equinix_fabric_connection" "primary_cloud_router_connection" {
  name = var.connection_name
  type = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  additional_info = var.additional_info != [] ? var.additional_info : null
  bandwidth       = var.bandwidth
  redundancy { priority = "PRIMARY" }
  order {
    purchase_order_number = var.purchase_order_number
  }
  a_side {
    access_point {
      type = var.aside_ap_type
      router {
        uuid = var.aside_fcr_uuid
      }
    }
  }
  dynamic "z_side" {
    #ports z_side type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
          type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside[0].id
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_ctag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_stag : null
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
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
          type= var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}

resource "equinix_fabric_connection" "secondary_cloud_router_connection" {
  count = var.secondary_connection_name != "" ? 1: 0
  name = var.connection_name
  type = var.connection_type
  notifications {
      type   = var.notifications_type
      emails = var.notifications_emails
  }
  additional_info = var.additional_info != [] ? var.additional_info : null
  bandwidth       = var.bandwidth
  redundancy {
      priority = "SECONDARY"
      group    = one(equinix_fabric_connection.primary_cloud_router_connection.redundancy).group
  }
  order {
      purchase_order_number = var.secondary_purchase_order_number
  }
  a_side {
      access_point {
        type = var.aside_ap_type

        router {
          uuid = var.aside_sec_fcr_uuid
        }
      }
  }
  dynamic "z_side" {
    #ports z_side type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside[0].id
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_ctag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_stag : null
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
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type= var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}
