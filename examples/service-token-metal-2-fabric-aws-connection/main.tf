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
resource "random_string" "random" {
  length  = 3
  special = false
}
locals {
  connection_name  = format("%s-%s", var.connection_name, random_string.random.result)
  metal_speed_unit = var.metal_connection_speed_unit == "GB" ? "Gbps" : "Mbps"
}
resource "equinix_metal_device" "s1" {
  hostname         = "tf-rocky9-server-${var.metal_connection_metro}-1"
  plan             = "m3.small.x86"
  metro            = lower(var.metal_connection_metro)
  operating_system = "rocky_9"
  billing_cycle    = "hourly"
  project_id       = var.metal_project_id
}
resource "equinix_metal_vlan" "vlan-server-1" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = lower(var.metal_connection_metro)
  project_id  = var.metal_project_id
}
resource "equinix_metal_device_network_type" "s1-network-type" {
  device_id = equinix_metal_device.s1.id
  type      = "hybrid"
}
resource "equinix_metal_port_vlan_attachment" "s1-attachment" {
  device_id = equinix_metal_device_network_type.s1-network-type.id
  port_name = "bond0"
  vlan_vnid = equinix_metal_vlan.vlan-server-1.vxlan
}
resource "equinix_metal_connection" "metal-connection" {
  name               = local.connection_name
  project_id         = var.metal_project_id
  metro              = var.metal_connection_metro
  redundancy         = "primary"
  type               = "shared"
  service_token_type = "a_side"
  description        = var.metal_connection_description
  tags               = ["terraform"]
  speed              = format("%d%s", var.connection_speed, local.metal_speed_unit)
  vlans              = [equinix_metal_vlan.vlan-server-1.vxlan] // required for shared connection
  contact_email      = "srpatel@equinix.com"
}
module "metal-2-fabric-connection" {
  source = "../../modules/service-token-connection"

  connection_name = var.connection_name
  connection_type = var.connection_type
  notifications_type = var.notifications_type
  notifications_emails = var.notifications_emails
  bandwidth = var.bandwidth
  purchase_order_number = var.purchase_order_number
  additional_info       = var.additional_info

  #A-Side
  aside_service_token_uuid = 	 equinix_metal_connection.metal-connection.service_tokens.0.id

  #Z-Side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_sp_name               = var.zside_sp_name
}
data "aws_dx_connection" "aws_connection" {
  depends_on = [
    module.metal-2-fabric-connection
  ]
  name = var.connection_name
}

resource "aws_dx_gateway" "aws_gateway" {
  depends_on = [
    module.metal-2-fabric-connection
  ]
  name            = var.aws_gateway_name
  amazon_side_asn = var.aws_gateway_asn
}

resource "aws_dx_private_virtual_interface" "aws_virtual_interface" {
  depends_on = [
    module.metal-2-fabric-connection,
    aws_dx_gateway.aws_gateway,
  ]
  connection_id    = data.aws_dx_connection.aws_connection.id
  name             = var.aws_vif_name
  vlan             = data.aws_dx_connection.aws_connection.vlan_id
  address_family   = var.aws_vif_address_family
  bgp_asn          = var.aws_vif_bgp_asn
  amazon_address   = var.aws_vif_amazon_address
  customer_address = var.aws_vif_customer_address
  bgp_auth_key     = var.aws_vif_bgp_auth_key
  dx_gateway_id   = aws_dx_gateway.aws_gateway.id
}