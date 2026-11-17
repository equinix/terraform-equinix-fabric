output "internet_access_service_id" {
  description = "UUID of the created service, confirmed by reading it back through the data source"
  value       = module.internet_access.get_uuid
}

output "internet_access_service_state" {
  value = module.internet_access.get_state
}

output "internet_access_service_routing_protocol" {
  value     = module.internet_access.get_routing_protocol
  sensitive = true
}

output "internet_access_search_total" {
  description = "Total number of Internet Access services returned by the search"
  value       = module.internet_access.search_total
}

output "internet_access_search_uuids" {
  description = "UUIDs of the Internet Access services returned by the search"
  value       = module.internet_access.search_uuids
}
