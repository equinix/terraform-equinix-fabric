provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
provider "google" {
  region      = var.gcp_region
  project     = var.gcp_project_id
  zone        = var.gcp_zone
  credentials = var.gcp_credentials_path

}
resource "google_compute_network" "port-gcp" {
  project                 = var.gcp_project_id
  name                    = var.gcp_network_name
  mtu                     = var.gcp_network_mtu
  auto_create_subnetworks = var.gcp_network_auto_create_subnetwork

}
resource "google_compute_router" "port-gcp" {
  name    = var.gcp_router_name
  network = google_compute_network.port-gcp.name
  bgp {
    asn = var.gcp_router_bgp_asn
  }
}

resource "google_compute_interconnect_attachment" "port-gcp" {
  name                     = var.gcp_interconnect_name
  type                     = var.gcp_interconnect_type
  router                   = google_compute_router.port-gcp.id
  region                   = var.gcp_region
  edge_availability_domain = var.gcp_interconnect_edge_availability_domain
}

module "create_port_2_google_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name      = var.aside_port_name
  aside_vlan_tag       = var.aside_vlan_tag
  aside_vlan_inner_tag = var.aside_vlan_inner_tag

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = google_compute_interconnect_attachment.port-gcp.pairing_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.gcp_region
  zside_sp_name               = var.zside_sp_name
}
