output "virtual_device_2_ntp_connection_id" {
  value = module.virtual_device_2_precision_time_ntp.primary_connection_id
}

output "npt_ept_resource_id" {
  value = equinix_fabric_precision_time_service.ntp.id
}