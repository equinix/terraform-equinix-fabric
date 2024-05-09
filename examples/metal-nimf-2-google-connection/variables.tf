variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
  sensitive   = true
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
  sensitive   = true
}
#Metal Connection
variable "metal_auth_token" {
  description = "Equinix Metal Authentication API Token"
  type        = string
  sensitive   = true
}
variable "metal_connection_metro" {
  description = "Metro where the connection will be created"
  type        = string
}
variable "metal_project_id" {
  description = "Metal Project Name"
  type        = string
}
variable "metal_connection_name" {
  description = "Metal Connection Name"
  type        = string
}
variable "metal_connection_redundancy" {
  description = "Metal Connection redundancy - redundant or primary"
  type        = string
}
variable "metal_connection_speed" {
  description = "Metal Connection speed - one of 50Mbps, 200Mbps, 500Mbps, 1Gbps, 2Gbps, 5Gbps, 10Gbps"
  type        = string
}
variable "metal_connection_type" {
  description = "Metal Connection type - dedicated , shared or shared_port_vlan"
  type        = string
}
variable "metal_contact_email" {
  description = "Preferred email used for communication"
  type        = string
}
#Google Provider
variable "google_region" {
  description = "The Google region to manage resources in"
  type        = string
}
variable "google_project_id" {
  description = "The default Google Project Id to manage resources in"
  type        = string
}
variable "google_zone" {
  description = "The default Google Zone to manage resources in"
  type        = string
}
variable "google_credentials_path" {
  description = "Path to the contents of a service account key file in JSON format"
  type        = string
}
variable "google_network_name" {
  description = "The Google Network Name"
  type        = string
}
variable "google_network_mtu" {
  description = "The Google Network Maximum Transmission Unit in bytes"
  type        = string
}
variable "google_network_auto_create_subnetwork" {
  description = "When set to true, the network is created in auto subnet mode"
  type        = bool
}
variable "google_router_name" {
  description = "The Google Router Name"
  type        = string
}
variable "google_router_bgp_asn" {
  description = "The Google Router Local BGP Autonomous System Number (ASN)"
  type        = string
}
variable "google_interconnect_name" {
  description = "The Google Interconnect Name"
  type        = string
}
variable "google_interconnect_type" {
  description = "The Google Interconnect Type"
  type        = string
}
variable "google_interconnect_edge_availability_domain" {
  description = "The Google Interconnect Edge Availability Domain"
  type        = string
}
#Fabric Connection
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "notifications_type" {
  description = "Notification Type - ALL is the only type currently supported"
  type        = string
  default     = "ALL"
}
variable "notifications_emails" {
  description = "Array of contact emails"
  type        = list(string)
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "project_id" {
  description = "Equinix Fabric Project Id"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
