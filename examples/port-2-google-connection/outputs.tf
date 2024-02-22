output "GCP_Network_Id" {
  value = google_compute_network.port-gcp.id
}
output "GCP_Router_Id" {
  value = google_compute_router.port-gcp.id
}
output "GCP_interconnect_Id" {
  value = google_compute_interconnect_attachment.port-gcp.id
}
output "google_connection_id" {
  value = module.create_port_2_google_connection.primary_connection_id
}
