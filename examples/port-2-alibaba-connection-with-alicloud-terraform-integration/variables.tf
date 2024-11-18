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
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
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
variable "aside_port_name" {
  description = "Equinix A-Side Port Name"
  type        = string
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
variable "aside_vlan_inner_tag" {
  description = "Vlan Inner Tag information, inner vlanCTag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
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
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
}
variable "region" {
  description = "Region"
  type        = string
}
variable "access_point_id" {
  description = "Access Point ID"
  type        = string
  default     = ""
}
variable "local_gateway_ip" {
  description = "Local Gateway IP"
  type        = string
  default     = ""
}
variable "peer_gateway_ip" {
  description = "Peer Gateway IP"
  type        = string
  default     = ""
}
variable "peering_subnet_mask" {
  description = "Peering Subnet Mask"
  type        = string
  default     = ""
}
variable "min_rx_interval" {
  description = "Minimum RX Interval"
  type        = string
  default     = ""
}
variable "min_tx_interval" {
  description = "Minimum TX Interval"
  type        = string
  default     = ""
}
variable "detect_multiplier" {
  description = "Detect Multiplier"
  type        = string
  default     = ""
}
variable "virtual_border_router_name" {
  description = "Virtual Border Router Name"
  type        = string
  default     = ""
}
variable "access_key" {
  description = "Access Key"
  type        = string
  sensitive   = true
}
variable "secret_key" {
  description = "Secret Key"
  type        = string
  sensitive   = true
}
