output "id" {
  description = "Identifier of the ASN resource"
  value       = one(equinix_fabric_asn.this[*].id)
}

output "uuid" {
  description = "UUID of the ASN"
  value       = one(equinix_fabric_asn.this[*].uuid)
}

output "href" {
  description = "URI of the ASN"
  value       = one(equinix_fabric_asn.this[*].href)
}

output "state" {
  description = "State of the ASN"
  value       = one(equinix_fabric_asn.this[*].state)
}

output "number" {
  description = "Autonomous System Number"
  value       = one(equinix_fabric_asn.this[*].number)
}

output "assets" {
  description = "Assets the ASN is attached to"
  value       = one(equinix_fabric_asn.this[*].assets)
}

output "change_log" {
  description = "Audit log of the ASN"
  value       = one(equinix_fabric_asn.this[*].change_log)
}

output "ownership_challenge_message" {
  description = "Challenge message of a PUBLIC_ASN that has to be signed to complete the verification"
  value       = try(equinix_fabric_asn.this[0].ownership_challenge_details.message, null)
}

output "get_uuid" {
  description = "UUID of the ASN read back through the data source"
  value       = data.equinix_fabric_asn.get.uuid
}

output "get_state" {
  value = data.equinix_fabric_asn.get.state
}

output "get_number" {
  value = data.equinix_fabric_asn.get.number
}

output "get_range" {
  value = data.equinix_fabric_asn.get.range
}

output "get_rir_region" {
  value = data.equinix_fabric_asn.get.rir_region
}

output "get_location" {
  value = data.equinix_fabric_asn.get.location
}

output "get_project" {
  value = data.equinix_fabric_asn.get.project
}

output "search_total" {
  description = "Total number of ASNs matching the search"
  value       = data.equinix_fabric_asns.search.pagination.total
}

output "search_uuids" {
  description = "UUIDs of the ASNs returned by the search"
  value       = [for r in data.equinix_fabric_asns.search.data : r.uuid]
}

output "search_asns" {
  description = "ASNs returned by the search"
  value       = data.equinix_fabric_asns.search.data
}
