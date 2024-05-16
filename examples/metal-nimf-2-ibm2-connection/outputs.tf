output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "Metal_IBM2_Connection_Id" {
  value = module.metal_2_google_connection.primary_connection_id
}
