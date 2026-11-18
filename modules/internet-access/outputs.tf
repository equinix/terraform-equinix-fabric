output "uuid" {
  description = "UUID of the Internet Access service"
  value       = one(equinix_fabric_internet_access_service.this[*].uuid)
}

output "href" {
  description = "URI of the Internet Access service"
  value       = one(equinix_fabric_internet_access_service.this[*].href)
}

output "state" {
  description = "Provisioning state of the service"
  value       = one(equinix_fabric_internet_access_service.this[*].state)
}

output "use_case" {
  description = "Use case of the service"
  value       = one(equinix_fabric_internet_access_service.this[*].use_case)
}

output "locations" {
  description = "Locations of the service"
  value       = one(equinix_fabric_internet_access_service.this[*].locations)
}

output "billing" {
  description = "Billing details of the service"
  value       = one(equinix_fabric_internet_access_service.this[*].billing)
}

output "change_log" {
  description = "Audit log of the service"
  value       = one(equinix_fabric_internet_access_service.this[*].change_log)
}
