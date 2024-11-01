output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "aws_connection" {
  value = module.virtual_device_2_aws_connection.primary_connection
  sensitive = true
}
