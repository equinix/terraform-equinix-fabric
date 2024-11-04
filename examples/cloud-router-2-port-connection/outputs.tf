output "port_connection" {
  value = module.cloud_router_port_connection.primary_connection
  sensitive = true
}

output "port_connection_id" {
  value = module.cloud_router_port_connection.primary_connection_id
}
