provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
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
module "cloud_router_2_metal_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code
}

module "routing_protocols" {
  depends_on = [module.cloud_router_2_metal_connection]
  source     = "../../modules/cloud-router-routing-protocols"

  connection_uuid = module.cloud_router_2_metal_connection.primary_connection_id

  # Direct RP Details
  direct_rp_name         = var.direct_rp_name
  direct_equinix_ipv4_ip = var.direct_equinix_ipv4_ip
}

resource "time_sleep" "wait_dl_connection" {
  depends_on      = [module.routing_protocols]
  create_duration = "2m"
}

data "equinix_metal_connection" "NIMF-test" {
  depends_on    = [time_sleep.wait_dl_connection]
  connection_id = equinix_metal_connection.metal-connection.id
}
