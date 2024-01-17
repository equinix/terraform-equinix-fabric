output "aws_connection_id" {
  value = module.port_2_aws_connection.primary_connection_id
}
output "asw_vpc_id" {
  value = aws_vpc.example.id
}
output "aws_vpn_gateway_id" {
  value = aws_vpn_gateway.example.id
}
output "aws_interface_id" {
  value = aws_dx_private_virtual_interface.example.id
}
