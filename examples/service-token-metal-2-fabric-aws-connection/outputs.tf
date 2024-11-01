output "metal-connection" {
  value = equinix_metal_connection.metal-connection.id
}
output "fabric-connection" {
  value = module.metal-2-fabric-connection.primary_connection
  sensitive = true
}
output "aws_dx_gateway_id" {
  value = aws_dx_gateway.aws_gateway.id
}
output "aws_interface_id" {
  value = aws_dx_private_virtual_interface.aws_virtual_interface.id
}
