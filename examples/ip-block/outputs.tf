output "ip_block_id" {
  description = "UUID of the IP block, confirmed by reading it back through the data source"
  value       = data.equinix_fabric_ip_block.get.uuid
}

output "ip_block_prefix" {
  value = data.equinix_fabric_ip_block.get.prefix
}

output "ip_block_state" {
  value = data.equinix_fabric_ip_block.get.state
}

output "ip_block_search_total" {
  description = "Total number of IP blocks returned by the search"
  value       = data.equinix_fabric_ip_blocks.search.pagination.total
}

output "ip_block_search_uuids" {
  description = "UUIDs of the IP blocks returned by the search"
  value       = [for r in data.equinix_fabric_ip_blocks.search.data : r.uuid]
}
