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

module "create_port_2_network_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag
  aside_location  = var.aside_location

  # Z-side
  zside_ap_type       = var.zside_ap_type
  zside_network_uuid  = equinix_fabric_network.etree_network.id
  role                = var.role
}
