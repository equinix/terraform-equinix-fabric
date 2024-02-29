output "GCP_Network_Id" {
  value = google_compute_network.port-google.id
}
output "GCP_Router_Id" {
  value = google_compute_router.port-google.id
}
output "GCP_Interconnect_Id" {
  value = google_compute_interconnect_attachment.port-google.id
}
output "google_connection_id" {
  value = module.create_port_2_google_connection.primary_connection_id
}
