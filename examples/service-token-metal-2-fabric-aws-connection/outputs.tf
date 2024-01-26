output "metal-connection" {
  value = equinix_metal_connection.metal-connection.id
}
output "fabric-connection" {
  value = module.metal-2-fabric-connection.primary_connection_id
}
output "aws_vpc_id" {
  value = aws_vpc.example.id
}
output "aws_vpn_gateway_id" {
  value = aws_vpn_gateway.example.id
}
output "aws_interface_id" {
  value = aws_dx_private_virtual_interface.example.id
}
