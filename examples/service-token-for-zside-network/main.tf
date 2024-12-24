provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
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
    supported_bandwidths = var.supported_bandwidths
    z_side {
      access_point_selectors {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}
