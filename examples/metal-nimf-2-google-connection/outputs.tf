output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "GCP_Network_Id" {
  value = google_compute_network.metal-nimf-google.id
}
output "GCP_Router_Id" {
  value = google_compute_router.metal-nimf-google.id
}
output "GCP_Interconnect_Id" {
  value = google_compute_interconnect_attachment.metal-nimf-google.id
}
output "Metal_Google_Connection_Id" {
  value = module.metal_2_google_connection.primary_connection_id
}
