provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_network" "etree_network" {
  name  = var.network_name
  type  = var.network_type
  scope = var.network_scope
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
}

resource "equinix_fabric_service_token" "service-token" {
  type                 = "VC_TOKEN"
  name                 = var.service_token_name
  description          = var.service_token_description
  expiration_date_time = var.service_token_expiration_date_time
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
  service_token_connection {
    type                    = var.connection_type
    allow_remote_connection = true
    supported_bandwidths    = var.supported_bandwidths
    z_side {
      access_point_selectors {
        type = "NETWORK"
        network {
          uuid = equinix_fabric_network.etree_network.id
        }
      }
    }
  }
}

module "port_2_network_service_token_connection_id" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  term_length           = var.term_length

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_service_token_uuid = equinix_fabric_service_token.service-token.id
}
