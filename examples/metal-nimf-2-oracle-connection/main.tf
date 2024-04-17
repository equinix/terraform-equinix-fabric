provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
provider "oci" {
  tenancy_ocid      = var.oracle_tenancy_ocid
  user_ocid         = var.oracle_user_ocid
  private_key_path  = var.oracle_private_key_path
  fingerprint       = var.oracle_fingerprint
  region            = var.oracle_region
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

data "oci_core_fast_connect_provider_services" "fc_provider_services" {
  compartment_id = var.oracle_compartment_id
}

locals {
  fc_provider_services_id = element(
    data.oci_core_fast_connect_provider_services.fc_provider_services.fast_connect_provider_services,
    index(
      data.oci_core_fast_connect_provider_services.fc_provider_services.fast_connect_provider_services.*.provider_name,
      var.oracle_fastconnect_provider
    )
  ).id
}

resource "oci_core_virtual_circuit" "test_virtual_circuit" {
  display_name          = var.oracle_vc_display_name
  compartment_id        = var.oracle_compartment_id
  type                  = var.oracle_vc_type
  bandwidth_shape_name  = var.oracle_bandwidth
  cross_connect_mappings {
    customer_bgp_peering_ip = var.oracle_customer_bgp_peering_ip
    oracle_bgp_peering_ip   = var.oracle_bgp_peering_ip
  }
  customer_asn        = var.oracle_customer_asn
  region              = var.oracle_region
  provider_service_id = local.fc_provider_services_id
  gateway_id          = var.oracle_gateway_id
}

module "metal_2_oracle_connection" {
  source = "../../modules/metal-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  aside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = oci_core_virtual_circuit.test_virtual_circuit.id
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.oracle_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
