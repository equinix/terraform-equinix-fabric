output "FCR_VD_Primary_Connection" {
  value = module.cloud_router_virtual_device_redundant_connection.primary_connection
  sensitive = true
}
output "FCR_VD_Secondary_Connection" {
  value = module.cloud_router_virtual_device_redundant_connection.secondary_connection
  sensitive = true
}

output "FCR_VD_Primary_Connection_id" {
  value = module.cloud_router_virtual_device_redundant_connection.primary_connection_id
}
output "FCR_VD_Secondary_Connection_id" {
  value = module.cloud_router_virtual_device_redundant_connection.secondary_connection_id
}

