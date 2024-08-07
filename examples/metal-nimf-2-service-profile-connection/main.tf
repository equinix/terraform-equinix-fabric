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

module "metal_2_service_profile" {
  source = "../../modules/metal-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  additional_info       = var.additional_info
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  aside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_fabric_sp_name  = var.zside_fabric_sp_name
}

resource "time_sleep" "wait_connection" {
  depends_on      = [module.metal_2_service_profile]
  create_duration = "2m"
}

data "equinix_metal_connection" "NIMF-test" {
  depends_on    = [module.metal_2_service_profile]
  connection_id = equinix_metal_connection.metal-connection.id
}
