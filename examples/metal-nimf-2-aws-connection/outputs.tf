output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "metal_aws_connection_id" {
  value = module.metal_2_aws_connection.primary_connection_id
}
output "aws_dx_gateway_id" {
  value = aws_dx_gateway.aws_gateway.id
}
output "aws_interface_id" {
  value = aws_dx_private_virtual_interface.aws_virtual_interface.id
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}