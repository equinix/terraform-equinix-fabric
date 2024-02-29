provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

provider "google" {
  region      = var.google_region
  project     = var.google_project_id
  zone        = var.google_zone
  credentials = var.google_credentials_path
}

resource "google_compute_network" "cloud-router-google" {
  project                 = var.google_project_id
  name                    = var.google_network_name
  mtu                     = var.google_network_mtu
  auto_create_subnetworks = var.google_network_auto_create_subnetwork
}

resource "google_compute_router" "cloud-router-google" {
  name    = var.google_router_name
  network = google_compute_network.cloud-router-google.name
  bgp {
    asn = var.google_router_bgp_asn
  }
}

resource "google_compute_interconnect_attachment" "cloud-router-google" {
  name                     = var.google_interconnect_name
  type                     = var.google_interconnect_type
  router                   = google_compute_router.cloud-router-google.id
  region                   = var.google_region
  edge_availability_domain = var.google_interconnect_edge_availability_domain
}

module "cloud_router_google_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_type  = var.aside_ap_type
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = google_compute_interconnect_attachment.cloud-router-google.pairing_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.google_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
