output "id" {
  description = "Identifier of the Internet Access service resource"
  value       = one(equinix_fabric_internet_access_service.this[*].id)
}

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

output "get_uuid" {
  description = "UUID of the service read back through the data source"
  value       = data.equinix_fabric_internet_access_service.get.uuid
}

output "get_state" {
  value = data.equinix_fabric_internet_access_service.get.state
}

output "get_routing_protocol" {
  value     = data.equinix_fabric_internet_access_service.get.routing_protocol
  sensitive = true
}

output "search_total" {
  description = "Total number of Internet Access services matching the search"
  value       = data.equinix_fabric_internet_access_services.search.pagination.total
}

output "search_uuids" {
  description = "UUIDs of the services returned by the search"
  value       = [for r in data.equinix_fabric_internet_access_services.search.data : r.uuid]
}

output "search_internet_access_services" {
  description = "Services returned by the search"
  value       = data.equinix_fabric_internet_access_services.search.data
}
