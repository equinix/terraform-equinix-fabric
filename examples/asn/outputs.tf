output "asn_id" {
  description = "UUID of the created ASN, confirmed by reading it back through the data source (get)"
  value       = module.asn.get_uuid
}

output "asn_number" {
  description = "Autonomous System Number assigned by Equinix"
  value       = module.asn.number
}

output "asn_state" {
  value = module.asn.get_state
}

output "asn_search_total" {
  description = "Total number of ASNs returned by the search"
  value       = module.asn.search_total
}

output "asn_search_uuids" {
  description = "UUIDs of the ASNs returned by the search"
  value       = module.asn.search_uuids
}
