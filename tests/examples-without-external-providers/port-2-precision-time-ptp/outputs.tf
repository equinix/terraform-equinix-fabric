output "port_2_ptp_connection_id" {
  value = module.create_port_2_precision_time_ptp_service_profile.primary_connection_id
}

output "ptp_ept_resource_id" {
  value = equinix_fabric_precision_time_service.ptp.id
}
