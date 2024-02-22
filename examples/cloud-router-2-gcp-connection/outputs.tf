output "GCP_Network_Id" {
  value = google_compute_network.port-gcp.id
}
output "GCP_Router_Id" {
  value = google_compute_router.port-gcp.id
}
output "GCP_interconnect_Id" {
  value = google_compute_interconnect_attachment.port-gcp.id
}
output "module_output" {
  value = module.cloud_router_gcp_connection.primary_connection_id
}
