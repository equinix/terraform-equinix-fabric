# output "sp_name" {
#   description = "Service profile Name"
#   value = equinix_fabric_service_profile.sp-test-1.name
# }

output "zside_sp_uuid" {
  description = "Z-side service profile UUID used for the connection"
  value       = data.equinix_fabric_service_profiles.sp-test.id
}


# output "primary_connection_id" {
#   description = "Primary port connection ID"
#   value       = module.create_port_2_private_sp_primary_connection.primary_connection_id
# }
#
# output "primary_and_secondary_connection_id" {
#   description = "Primary port connection ID"
#   value       = [module.port_2_private_sp_connection_primary_and_secondary.primary_connection_id, module.port_2_private_sp_connection_primary_and_secondary.secondary_connection_id]
# }



