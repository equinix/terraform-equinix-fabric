terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
    }
  }
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "routing_protocols" {
  source = "../../modules/routing-protocols"

  connection_uuid = var.connection_uuid

  # Direct RP Details
  direct_rp_name = var.direct_rp_name
  direct_equinix_ipv4_ip = var.direct_equinix_ipv4_ip
  direct_equinix_ipv6_ip = var.direct_equinix_ipv6_ip

  # BGP RP Details
  bgp_rp_name = var.bgp_rp_name
  bgp_customer_asn = var.bgp_customer_asn
  bgp_customer_peer_ipv4 = var.bgp_customer_peer_ipv4
  bgp_enabled_ipv4 = var.bgp_enabled_ipv4
  bgp_customer_peer_ipv6 = var.bgp_customer_peer_ipv6
  bgp_enabled_ipv6 = var.bgp_enabled_ipv6
}
