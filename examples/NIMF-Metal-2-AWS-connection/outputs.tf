output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "metal_aws_connection_id" {
  value = equinix_fabric_connection.metal-2-aws-connection.id
}
