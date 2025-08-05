provider "equinix" {
  sts_source_token = var.sts_source_token
  sts_auth_scope = var.sts_auth_scope
}

module "create_port_2_port_connection" {
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

  # Z-side
  zside_ap_type   = var.zside_ap_type
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
  zside_location  = var.zside_location
}
