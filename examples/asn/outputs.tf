output "asn_id" {
  description = "UUID of the ASN, confirmed by reading it back through the data source"
  value       = data.equinix_fabric_asn.get.uuid
}

output "asn_number" {
  description = "Autonomous System Number"
  value       = data.equinix_fabric_asn.get.number
}

output "asn_state" {
  value = data.equinix_fabric_asn.get.state
}

output "asn_search_total" {
  description = "Total number of ASNs returned by the search"
  value       = data.equinix_fabric_asns.search.pagination.total
}

output "asn_search_uuids" {
  description = "UUIDs of the ASNs returned by the search"
  value       = [for r in data.equinix_fabric_asns.search.data : r.uuid]
}
