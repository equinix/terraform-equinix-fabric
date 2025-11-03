output "service_profile_connection" {
  value = module.cloud_router_sp_connection.primary_connection
  sensitive = true
}

output "service_profile_connection_id" {
  value = module.cloud_router_sp_connection.primary_connection_id
}
