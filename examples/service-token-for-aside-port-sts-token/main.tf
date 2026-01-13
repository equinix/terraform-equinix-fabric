provider "equinix" {
  token_exchange_subject_token = var.sts_source_token
  token_exchange_scope = var.sts_auth_scope
}
data "equinix_fabric_ports" "aside_port" {
  filters {
    name = var.aside_port_name
  }
}

resource "equinix_fabric_service_token" "service-token" {
  type                 = var.service_token_type
  name                 = var.service_token_name
  description          = var.service_token_description
  expiration_date_time = var.service_token_expiration_date_time
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }

  service_token_connection {
    type                 = var.connection_type
    bandwidth_limit      = var.bandwidth_limit
    a_side {
      access_point_selectors {
        type = var.aside_ap_type
        port {
          uuid = data.equinix_fabric_ports.aside_port.data.0.uuid
        }
        link_protocol {
          type     = var.aside_vlan_tag_type
          vlan_tag = var.aside_vlan_tag
        }
      }
    }
  }
}
