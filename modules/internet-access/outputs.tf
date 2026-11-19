output "uuid" {
  description = "UUID of the Internet Access service"
  value       = equinix_fabric_internet_access_service.this.uuid
}

output "state" {
  description = "Provisioning state of the service"
  value       = equinix_fabric_internet_access_service.this.state
}

output "connection_uuid" {
  description = "UUID of the IA_VC connection attached to the service"
  value       = module.ia_connection.primary_connection.uuid
}

output "ip_block_uuid" {
  description = "UUID of the IP block used as customer route"
  value       = equinix_fabric_ip_block.this.uuid
}
