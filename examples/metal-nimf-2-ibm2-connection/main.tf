provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}

provider "ibm" {
  ibmcloud_api_key      = var.ibm_cloud_api_key
  iaas_classic_username = var.ibm_classic_username
  iaas_classic_api_key  = var.ibm_classic_api_key
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

module "metal_2_ibm2_connection" {
  source = "../../modules/metal-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
  additional_info             = var.additional_info
}

resource "time_sleep" "wait_dl_connection" {
  create_duration = "1m"
}

data "ibm_dl_gateway" "test_ibm_dl_gateway" {
  name        = var.connection_name
  depends_on  = [time_sleep.wait_dl_connection]
}

data "ibm_resource_group" "rg" {
  name = var.ibm_resource_group_name
}

resource "ibm_dl_gateway_action" "test_dl_gateway_action" {
  gateway         = data.ibm_dl_gateway.test_ibm_dl_gateway.id
  action          = var.ibm_gateway_action
  global          = var.ibm_gateway_global
  metered         = var.ibm_gateway_metered
  resource_group  = data.ibm_resource_group.rg.id
}
