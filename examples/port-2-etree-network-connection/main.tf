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
