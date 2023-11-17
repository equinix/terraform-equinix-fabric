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
    values   = [var.fabric_sp_name]
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
  redundancy { priority = var.redundancy }
  order {
    purchase_order_number = var.purchase_order_number
  }
  a_side {
    access_point {
      type = var.aside_ap_type
      router {
        uuid = var.fcr_uuid
      }
    }
  }
  dynamic "z_side" {
    #ports z_side type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
          type = var.zside_ap_type != "" ? var.zside_ap_type : null
        port {
          uuid = data.equinix_fabric_ports.zside[0].id
        }
        link_protocol {
          type       = var.zside_link_protocol_type != "" ? var.zside_link_protocol_type : null
          vlan_tag   = var.zside_link_protocol_type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_c_tag = var.zside_link_protocol_type == "QINQ" ? var.zside_vlan_ctag : null
          vlan_s_tag = var.zside_link_protocol_type == "QINQ" ? var.zside_vlan_stag : null
        }
        location {
          metro_code = var.zside_location != "" ? var.zside_location : null
        }
      }
    }
  }
  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type != "" ? var.zside_ap_type : null
        authentication_key = var.zside_ap_authentication_key != "" ? var.zside_ap_authentication_key : null
        seller_region      = var.seller_region != "" ? var.seller_region : null
        peering_type       = var.peering_type != "" ? var.peering_type : null
        profile {
          type = var.zside_ap_profile_type != "" ? var.zside_ap_profile_type : null
          uuid = data.equinix_fabric_service_profiles.zside[0].id
        }
        location {
          metro_code = var.zside_location != "" ? var.zside_location : null
        }
      }
    }
  }
  dynamic "z_side" {
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
          type= var.zside_ap_type != "" ? var.zside_ap_type : null
        network {
          uuid = var.network_uuid != "" ? var.network_uuid : null
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
      priority = var.secondary_redundancy == "SECONDARY" ? var.secondary_redundancy : null
      group    = one(equinix_fabric_connection.primary_cloud_router_connection.redundancy).group
    }
    order {
      purchase_order_number = var.secondary_purchase_order_number
    }
    a_side {
      access_point {
        type = var.aside_ap_type

        router {
          uuid = var.sec_fcr_uuid
        }
      }
    }
  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type != "" ? var.zside_ap_type : null
        authentication_key = var.zside_ap_authentication_key != "" ? var.zside_ap_authentication_key : null
        seller_region      = var.seller_region != "" ? var.seller_region : null
        peering_type       = var.peering_type != "" ? var.peering_type : null
        profile {
          type = var.zside_ap_profile_type != "" ? var.zside_ap_profile_type : null
          uuid = data.equinix_fabric_service_profiles.zside[0].id
        }
        location {
          metro_code = var.zside_location != "" ? var.zside_location : null
        }
      }
    }
  }
}
