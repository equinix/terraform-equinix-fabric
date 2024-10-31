output "GCP_Network_Id" {
  value = google_compute_network.cloud-router-google.id
}
output "GCP_Router_Id" {
  value = google_compute_router.cloud-router-google.id
}
output "GCP_Interconnect_Id" {
  value = google_compute_interconnect_attachment.cloud-router-google.id
}
output "Google_Connection" {
  value = module.cloud_router_google_connection.primary_connection
}
