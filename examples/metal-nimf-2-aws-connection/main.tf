provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
provider "aws" {
  access_key = var.additional_info[0]["value"]
  secret_key = var.additional_info[1]["value"]
  region     = var.zside_seller_region
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

module "metal_2_aws_connection" {
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

  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_seller_region         = var.zside_seller_region
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}

data "aws_dx_connection" "aws_connection" {
  depends_on = [
    module.metal_2_aws_connection
  ]
  name = var.connection_name
}

resource "aws_dx_gateway" "aws_gateway" {
  depends_on = [
    module.metal_2_aws_connection
  ]
  name            = var.aws_gateway_name
  amazon_side_asn = var.aws_gateway_asn
}

resource "aws_dx_private_virtual_interface" "aws_virtual_interface" {
  depends_on = [
    module.metal_2_aws_connection,
    aws_dx_gateway.aws_gateway
  ]
  connection_id    = data.aws_dx_connection.aws_connection.id
  name             = var.aws_vif_name
  vlan             = data.aws_dx_connection.aws_connection.vlan_id
  address_family   = var.aws_vif_address_family
  bgp_asn          = var.aws_vif_bgp_asn
  amazon_address   = var.aws_vif_amazon_address
  customer_address = var.aws_vif_customer_address
  bgp_auth_key     = var.aws_vif_bgp_auth_key
  dx_gateway_id    = aws_dx_gateway.aws_gateway.id
}

resource "time_sleep" "wait_dl_connection" {
  depends_on = [module.metal_2_aws_connection]
  create_duration = "2m"
}

data "equinix_metal_connection" "NIMF-test" {
  depends_on = [time_sleep.wait_dl_connection]
  connection_id     = equinix_metal_connection.metal-connection.id
}
