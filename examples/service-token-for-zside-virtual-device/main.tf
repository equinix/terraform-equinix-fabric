provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

#Network Edge Module
resource "equinix_network_acl_template" "wan-acl-template" {
  name        = var.template_name
  description = var.template_description
  inbound_rule {
    subnet   = var.template_subnet
    protocol = var.template_protocol
    src_port = var.template_src_port
    dst_port = var.template_dst_port
  }
}

resource "equinix_network_device" "C8KV-SV" {
  name            = var.ne_name
  metro_code      = var.ne_metro_code
  type_code       = var.ne_type_code
  self_managed    = true
  byol            = true
  package_code    = var.ne_package_code
  notifications   = var.ne_notifications
  hostname        = var.ne_hostname
  account_number  = var.ne_account_number
  version         = var.ne_version
  core_count      = var.ne_core_count
  term_length     = var.ne_term_length

  ssh_key {
    username = var.ne_ssh_key_username
    key_name = var.ne_ssh_key_name
  }
  acl_template_id = equinix_network_acl_template.wan-acl-template.id
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
        virtual_device {
          type = var.zside_vd_type
          uuid = var.zside_vd_uuid
        }
        interface {
          type = var.zside_interface_type
        }
      }
    }
  }
}
