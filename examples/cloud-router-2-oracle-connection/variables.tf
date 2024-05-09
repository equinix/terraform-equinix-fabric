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
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
  default     = ""
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
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
  default     = "L2_PROFILE"
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = "SP"
}
variable "zside_peering_type" {
  description = "Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  default     = "PRIVATE"
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "oracle_tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
  sensitive   = true
}
variable "oracle_user_ocid" {
  description = "User OCID"
  type        = string
  sensitive   = true
}
variable "oracle_private_key" {
  description = "Oracle Private Key"
  type        = string
}
variable "oracle_fingerprint" {
  description = "Fingerprint for the key pair being used"
  type        = string
  sensitive   = true
}
variable "oracle_region" {
  description = "OCI region"
  type        = string
}
variable "oracle_compartment_id" {
  description = "The OCID of the compartment"
  type        = string
  sensitive   = true
}
variable "oracle_fastconnect_provider" {
  description = "Fast Connect Provider Name"
  type        = string
}
variable "oracle_vc_display_name" {
  description = "OCI Virtual Circuit Name"
  type        = string
}
variable "oracle_vc_type" {
  description = "The type of IP addresses used in this virtual circuit - PRIVATE"
  type        = string
}
variable "oracle_bandwidth" {
  description = "The provisioned connection bandwidth"
  type        = string
}
variable "oracle_customer_bgp_peering_ip" {
  description = "The BGP IPv4 address for the router on the other end of the BGP session from Oracle"
  type        = string
}
variable "oracle_bgp_peering_ip" {
  description = "The BGP IPv6 address for the router on the other end of the BGP session from Oracle"
  type        = string
}
variable "oracle_customer_asn" {
  description = "Oracle BGP ASN"
  type        = string
}
variable "oracle_gateway_id" {
  description = "The OCID of the dynamic routing gateway (DRG) that virtual circuit uses"
  type        = string
}
