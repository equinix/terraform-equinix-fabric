output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "aws_connection_id" {
  value = module.virtual_device_2_aws_connection.primary_connection_id
}