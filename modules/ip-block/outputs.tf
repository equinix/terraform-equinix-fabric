output "id" {
  description = "Identifier of the IP block resource"
  value       = one(equinix_fabric_ip_block.this[*].id)
}

output "uuid" {
  description = "UUID of the IP block"
  value       = one(equinix_fabric_ip_block.this[*].uuid)
}

output "href" {
  description = "URI of the IP block"
  value       = one(equinix_fabric_ip_block.this[*].href)
}

output "state" {
  description = "Provisioning state of the IP block"
  value       = one(equinix_fabric_ip_block.this[*].state)
}

output "prefix" {
  description = "Assigned IP prefix, e.g. 192.0.2.0/30"
  value       = one(equinix_fabric_ip_block.this[*].prefix)
}

output "prefix_length" {
  description = "Prefix length of the IP block"
  value       = one(equinix_fabric_ip_block.this[*].prefix_length)
}

output "ownership" {
  description = "Ownership of the IP block (EQUINIX or CUSTOMER)"
  value       = one(equinix_fabric_ip_block.this[*].ownership)
}

output "get_uuid" {
  description = "UUID of the IP block read back through the data source"
  value       = data.equinix_fabric_ip_block.get.uuid
}

output "get_state" {
  value = data.equinix_fabric_ip_block.get.state
}

output "get_prefix" {
  value = data.equinix_fabric_ip_block.get.prefix
}

output "get_prefix_length" {
  value = data.equinix_fabric_ip_block.get.prefix_length
}

output "get_ownership" {
  value = data.equinix_fabric_ip_block.get.ownership
}

output "get_location" {
  value = data.equinix_fabric_ip_block.get.location
}

output "get_project" {
  value = data.equinix_fabric_ip_block.get.project
}

output "search_total" {
  description = "Total number of IP blocks matching the search"
  value       = data.equinix_fabric_ip_blocks.search.pagination.total
}

output "search_uuids" {
  description = "UUIDs of the IP blocks returned by the search"
  value       = [for r in data.equinix_fabric_ip_blocks.search.data : r.uuid]
}

output "search_ip_blocks" {
  description = "IP blocks returned by the search"
  value       = data.equinix_fabric_ip_blocks.search.data
}
