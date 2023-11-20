output "module_output" {
  value = module.cloud_router_azure_redundant_connection.primary_connection_id
}
output "secondary_connection_result" {
  value = var.secondary_connection_name != "" ? module.cloud_router_azure_redundant_connection.secondary_connection_id : null
}
