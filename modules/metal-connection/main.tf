data "equinix_fabric_service_profiles" "zside" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_fabric_sp_name]
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
      type               = var.aside_ap_type
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
}
