output "wan_connection" {
  value = module.cloud_router_wan_connection.primary_connection
  sensitive = true
}

output "wan_connection_id" {
  value = module.cloud_router_wan_connection.primary_connection_id
}
