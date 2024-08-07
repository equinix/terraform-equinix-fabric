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
variable "aside_ap_authentication_key" {
  description = "Authentication key for metal based connections"
  type        = string
  sensitive   = true
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  sensitive   = true
  default     = ""
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "zside_peering_type" {
  description = "Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  default     = "PRIVATE"
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
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "zside_port_name" {
  description = "Equinix Z-Side Port Name"
  type        = string
  default     = ""
}
variable "zside_vlan_tag" {
  description = "VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_vlan_inner_tag" {
  description = "Inner VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
