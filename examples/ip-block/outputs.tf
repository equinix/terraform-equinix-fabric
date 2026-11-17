output "ip_block_id" {
  description = "UUID of the created IP block, confirmed by reading it back through the data source (get)"
  value       = module.ip_block.get_uuid
}

output "ip_block_prefix" {
  value = module.ip_block.get_prefix
}

output "ip_block_state" {
  value = module.ip_block.get_state
}

output "ip_block_search_total" {
  description = "Total number of IP blocks returned by the search"
  value       = module.ip_block.search_total
}

output "ip_block_search_uuids" {
  description = "UUIDs of the IP blocks returned by the search"
  value       = module.ip_block.search_uuids
}
