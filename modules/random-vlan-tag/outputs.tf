output "result" {
  description = "Generated random VLAN tag"
  value       = random_integer.vlan_tag.result
}

output "result_string" {
  description = "Generated random VLAN tag as string"
  value       = tostring(random_integer.vlan_tag.result)
}
