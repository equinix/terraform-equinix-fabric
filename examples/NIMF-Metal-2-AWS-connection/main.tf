provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
data "equinix_fabric_service_profiles" "zside_sp" {
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_sp_name]
  }
}
resource "equinix_metal_vlan" "vlan-server" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = var.metal_connection_metro
  project_id  = var.metal_project_id
}
resource "equinix_metal_connection" "metal-connection" {
  name          = var.metal_connection_name
  redundancy    = var.metal_connection_redundancy
  speed         = var.metal_connection_speed
  type          = var.metal_connection_type
  project_id    = var.metal_project_id
  metro         = var.metal_connection_metro
  vlans         = [equinix_metal_vlan.vlan-server.vxlan]
  contact_email = var.metal_contact_email
}
resource "equinix_fabric_connection" "metal-2-aws-connection" {
  name      = var.connection_name
  type      = var.connection_type
  bandwidth = var.bandwidth
  project {
    project_id = var.project_id
  }
  notifications {
    emails = var.notifications_emails
    type   = var.notifications_type
  }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }
  additional_info = var.additional_info != [] ? var.additional_info : null
  a_side {
    access_point {
      type               = var.aside_ap_type
      authentication_key = equinix_metal_connection.metal-connection.authorization_code
    }
  }
  z_side {
    access_point {
      type                = var.zside_ap_type
      authentication_key  = var.zside_ap_authentication_key
      seller_region       = var.zside_seller_region
      profile {
        type  = var.zside_ap_profile_type
        uuid  = data.equinix_fabric_service_profiles.zside_sp.data.0.uuid
      }
      location {
        metro_code  = var.zside_location
      }
    }
  }
}
