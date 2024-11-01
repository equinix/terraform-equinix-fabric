output "FCR_VD_Connection" {
  value = module.cloud_router_virtual_device_connection.primary_connection
  sensitive = true
}
