provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  endpoint      = var.equinix_endpoint
}
provider "aws" {
  access_key = var.additional_info[0]["value"]
  secret_key = var.additional_info[1]["value"]
  region     = var.zside_seller_region
}
module "port_2_aws_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  additional_info       = var.additional_info

  # A-side
  aside_port_name      = var.aside_port_name
  aside_vlan_tag       = var.aside_vlan_tag
  aside_vlan_inner_tag = var.aside_vlan_inner_tag

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_sp_name               = var.zside_sp_name
}

data "aws_dx_connection" "connection_id" {
  depends_on = [
    module.port_2_aws_connection
  ]
  name = var.connection_name
}
resource "aws_vpc" "example" {
  depends_on = [
    module.port_2_aws_connection
  ]
  cidr_block = var.aws_vpc_cidr_block
}

resource "aws_vpn_gateway" "example" {
  depends_on = [
#    aws_vpc.example,
    module.port_2_aws_connection
  ]
  vpc_id = aws_vpc.example.id
}

resource "aws_dx_private_virtual_interface" "example" {
  depends_on = [
    module.port_2_aws_connection,
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
