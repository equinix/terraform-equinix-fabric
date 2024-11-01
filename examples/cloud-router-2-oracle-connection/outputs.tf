output "oracle_connection" {
  value = module.cloud_router_oracle_connection.primary_connection
  sensitive = true
}
