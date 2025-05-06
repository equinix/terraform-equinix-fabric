output "virtual_device_2_ptp_connection_id" {
  value = module.create_virtual_device_2_precision_time_ptp.primary_connection_id
}

output "ntp_ept_resource_id" {
  value = equinix_fabric_precision_time_service.ptp.id
}
