output "metal-connection" {
  value = equinix_metal_connection.metal-connection.id
}

output "fabric-connection" {
  value = module.metal-2-fabric-connection.primary_connection_id
}
