output "module_output" {
  value = module.cloud_router_port_connection.primary_connection_result
}
output "secondary_connection_result" {
  value = var.secondary_connection_name != "" ? module.cloud_router_port_connection.secondary_connection_result : null
}