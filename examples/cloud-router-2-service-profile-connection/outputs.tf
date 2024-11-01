output "service_profile_connection" {
  value = module.cloud_router_sp_connection.primary_connection
  sensitive = true
}
