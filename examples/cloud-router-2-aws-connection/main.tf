provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
provider "aws" {
  access_key = var.additional_info[0]["value"]
  secret_key = var.additional_info[1]["value"]
  region     = var.zside_seller_region
}
module "cloud_router_aws_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  additional_info       = var.additional_info
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid
  aside_ap_type  = var.aside_ap_type

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}

data "aws_dx_connection" "connection_id" {
  depends_on = [
    module.cloud_router_aws_connection
  ]
  name = var.connection_name
}

resource "aws_vpc" "example" {
  depends_on = [
    module.cloud_router_aws_connection
  ]
  cidr_block = var.aws_vpc_cidr_block
}

resource "aws_vpn_gateway" "example" {
  depends_on = [
    module.cloud_router_aws_connection
  ]
  vpc_id = aws_vpc.example.id
}

resource "aws_dx_private_virtual_interface" "example" {
  depends_on = [
    module.cloud_router_aws_connection,
    aws_vpn_gateway.example,
    aws_vpc.example
  ]
  connection_id    = data.aws_dx_connection.connection_id.id
  name             = var.aws_vif_name
  vlan             = var.aws_vif_vlan
  address_family   = var.aws_vif_address_family
  bgp_asn          = var.aws_vif_bgp_asn
  amazon_address   = var.aws_vif_amazon_address
  customer_address = var.aws_vif_customer_address
  bgp_auth_key     = var.aws_vif_bgp_auth_key
  vpn_gateway_id   = aws_vpn_gateway.example.id
}

