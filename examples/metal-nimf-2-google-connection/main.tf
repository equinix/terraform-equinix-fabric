provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
provider "google" {
  region      = var.google_region
  project     = var.google_project_id
  zone        = var.google_zone
  credentials = var.google_credentials_path
}

resource "equinix_metal_vlan" "vlan-server" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = var.metal_connection_metro
  project_id  = var.metal_project_id
}

resource "equinix_metal_connection" "metal-connection" {
  name          = var.metal_connection_name
  redundancy    = var.metal_connection_redundancy
  speed         = var.metal_connection_speed
  type          = var.metal_connection_type
  project_id    = var.metal_project_id
  metro         = var.metal_connection_metro
  vlans         = [equinix_metal_vlan.vlan-server.vxlan]
  contact_email = var.metal_contact_email
}

resource "google_compute_network" "metal-nimf-google" {
  project                 = var.google_project_id
  name                    = var.google_network_name
  mtu                     = var.google_network_mtu
  auto_create_subnetworks = var.google_network_auto_create_subnetwork
}

resource "google_compute_router" "metal-nimf-google" {
  name    = var.google_router_name
  network = google_compute_network.metal-nimf-google.name
  bgp {
    asn = var.google_router_bgp_asn
  }
}

resource "google_compute_interconnect_attachment" "metal-nimf-google" {
  name                     = var.google_interconnect_name
  type                     = var.google_interconnect_type
  router                   = google_compute_router.metal-nimf-google.id
  region                   = var.google_region
  edge_availability_domain = var.google_interconnect_edge_availability_domain
}

module "metal_2_google_connection" {
  source = "../../modules/metal-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = google_compute_interconnect_attachment.metal-nimf-google.pairing_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.google_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}

resource "time_sleep" "wait_dl_connection" {
  depends_on = [module.metal_2_google_connection]
  create_duration = "2m"
}

data "equinix_metal_connection" "NIMF-test" {
  depends_on        = [time_sleep.wait_dl_connection]
  connection_id     = equinix_metal_connection.metal-connection.id
}
