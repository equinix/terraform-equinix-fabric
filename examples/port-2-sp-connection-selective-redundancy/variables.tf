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
variable "secondary_connection_name" {
  description = "Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
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
variable "allowed_emails" {
  description = "Array of allowed emails"
  type        = list(string)
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "secondary_bandwidth" {
  description = "Secondary Connection bandwidth in Mbps"
  type        = number
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_port_name_1" {
  description = "Equinix A-Side Port Name"
  type        = string
}
variable "aside_port_name_2_primary" {
  description = "Equinix A-Side Port Name Primary"
  type        = string
}
variable "aside_port_name_2_secondary" {
  description = "Equinix A-Side Port Name Secondary"
  type        = string
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, primary vlanSTag for DOT1Q connections"
  type        = string
}
variable "aside_vlan_tag_primary" {
  description = "Vlan Tag information, primary vlanSTag for DOT1Q connections"
  type        = string
}
variable "aside_vlan_tag_secondary" {
  description = "Vlan Tag information,  secondary vlanSTag for DOT1Q connections"
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
variable "sp_name" {
  description = "Service Profile name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "sp_description" {
  description = "Service Profile description. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "supported_bandwidths" {
  description = "List of permitted bandwidths"
  type        = list
  default     = []
}
variable "authentication_key_label" {
  description = "Authentication key Label for service profile"
  type        = string
  sensitive   = true
}
variable "authentication_key_description" {
  description = "Authentication key Description for service profile"
  type        = string
  sensitive   = true
}
variable "sp_uuid" {
  description = "Service Profile UUID"
  type        = string
}
variable "port_uuid_1" {
  description = "Port UUID 1"
  type        = string
}
variable "port_uuid_2" {
  description = "Port UUID 2"
  type        = string
}


