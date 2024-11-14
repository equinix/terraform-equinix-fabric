output "alibaba_connection" {
  value = module.create_port_2_alibaba_connection.primary_connection
  sensitive = true
}

output "alibaba_connection_id" {
  value = module.create_port_2_alibaba_connection.primary_connection_id
}

output "connection_name" {
  value = var.connection_name
  description = "The connection name used for this port connection"
}

output "alicloud_express_connect_virtual_border_router" {
  value = alicloud_express_connect_virtual_border_router.vbr
  sensitive = true
}

output "alicloud_express_connect_virtual_border_router_id" {
  value = alicloud_express_connect_virtual_border_router.vbr.id
}

output "express_connect_virtual_border_router_id" {
  value = data.alicloud_express_connect_virtual_border_routers.nameRegexVbr.routers.0.id
}
