output "port_2_npt_connection_id" {
  value = module.create_port_2_precision_time_ntp_service_profile.primary_connection_id
}

output "ntp_ept_resource_id" {
  value = equinix_fabric_precision_time_service.ntp.id
}
