output "internet_access_service_id" {
  description = "UUID of the service, confirmed by reading it back through the data source"
  value       = data.equinix_fabric_internet_access_service.get.uuid
}

output "internet_access_service_state" {
  value = data.equinix_fabric_internet_access_service.get.state
}

output "internet_access_service_routing_protocol" {
  value     = data.equinix_fabric_internet_access_service.get.routing_protocol
  sensitive = true
}

output "internet_access_search_total" {
  description = "Total number of Internet Access services returned by the search"
  value       = data.equinix_fabric_internet_access_services.search.pagination.total
}

output "internet_access_search_uuids" {
  description = "UUIDs of the Internet Access services returned by the search"
  value       = [for r in data.equinix_fabric_internet_access_services.search.data : r.uuid]
}
