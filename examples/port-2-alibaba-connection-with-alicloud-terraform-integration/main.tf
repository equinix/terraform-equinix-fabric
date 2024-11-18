provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_port_2_alibaba_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  project_id            = var.project_id

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_sp_name               = var.zside_sp_name
}

# provider "alicloud" {
#   access_key = var.access_key
#   secret_key = var.secret_key
#   region = var.region
# }
#
# data "alicloud_express_connect_physical_connections" "nameRegex" {
#   name_regex = "^${module.create_port_2_alibaba_connection.primary_connection.name}"
# }
#
# resource "alicloud_express_connect_virtual_border_router" "vbr" {
#   local_gateway_ip           = var.local_gateway_ip
#   peer_gateway_ip            = var.peer_gateway_ip
#   peering_subnet_mask        = var.peering_subnet_mask
#   physical_connection_id     = data.alicloud_express_connect_physical_connections.nameRegex.connections[0].id
#   virtual_border_router_name = var.virtual_border_router_name
#   vlan_id                    = one(one(one(module.create_port_2_alibaba_connection.primary_connection.z_side).access_point).link_protocol).vlan_tag
#   min_rx_interval            = var.min_rx_interval
#   min_tx_interval            = var.min_tx_interval
#   detect_multiplier          = var.detect_multiplier
# }
#
# resource "null_resource" "destroy_warning" {
#   triggers = {
#     warning = "WARNING: Destroy process is not complete yet. You need to delete the resource from Alibaba Portal!"
#   }
# }
#
# data "alicloud_express_connect_virtual_border_routers" "nameRegexVbr" {
#   name_regex = "^${alicloud_express_connect_virtual_border_router.vbr.virtual_border_router_name}"
# }
