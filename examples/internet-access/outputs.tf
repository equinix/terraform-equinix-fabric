output "internet_access_service_id" {
  description = "UUID of the created Internet Access service"
  value       = module.internet_access.uuid
}

output "internet_access_service_state" {
  description = "Provisioning state of the service"
  value       = module.internet_access.state
}
