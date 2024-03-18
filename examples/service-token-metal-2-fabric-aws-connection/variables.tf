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
variable "metal_auth_token" {
  description = "Equinix Metal Authentication API Token"
  type        = string
  sensitive   = true
}
variable "metal_connection_speed_unit" {
  description = "Unit of the speed/bandwidth to be allocated to the connection"
  type = string
  default = "MB"
}
variable "metal_connection_metro" {
  description = "Metro where the connection will be created"
  type        = string
}
variable "metal_project_id" {
  description = "Metal Project Name"
  type        = string
}
variable "metal_connection_description" {
  description = "Description for the connection resource"
  type        = string
  default     =  "Connect from Equinix Metal to Service provider using a-side token"
}
variable "connection_speed" {
  description = "Speed/Bandwidth to be allocated to the connection - (MB or GB)"
  type        = number
  default     = 50
}
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
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
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = ""
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  sensitive   = true
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = ""
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
variable "aws_vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
}
variable "aws_vif_name" {
  description = "The name for the virtual interface"
  type        = string
}
variable "aws_vif_vlan" {
  description = " The VLAN ID"
  type        = string
}
variable "aws_vif_address_family" {
  description = "The address family for the BGP peer. ipv4 or ipv6"
  type        = string
}
variable "aws_vif_bgp_asn" {
  description = "The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration"
  type        = number
}
variable "aws_vif_amazon_address" {
  description = "The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_customer_address" {
  description = "The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_bgp_auth_key" {
  description = "The authentication key for BGP configuration"
  type        =  string
  default     = ""
  sensitive   = true
}
