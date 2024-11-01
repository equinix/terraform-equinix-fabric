output "port_connection" {
  value = module.cloud_router_port_connection.primary_connection
  sensitive = true
}
