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
variable "zside_port_name" {
  description = "Equinix Zside Port Name"
  type        = string
  default     = ""
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  default     = ""
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
variable "zside_vlan_outer_tag" {
  description = "Access point protocol Vlan tag number for DOT1Q or QINQ connections"
  default     = ""
}
variable "zside_vlan_inner_tag" {
  description = "Access point protocol Vlan tag number for QINQ connections"
  default     = ""
}
variable "zside_peering_type" {
  description = "Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  default     = "PRIVATE"
}
variable "zside_network_uuid" {
  description = "Network UUID"
  default     = ""
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "secondary_connection_name" {
  description = "Secondary Connection name"
  type        = string
  default     = ""
}
variable "aside_fcr_uuid_sec" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "secondary_bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
  default     = 50
}
variable "aside_sec_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier for Secondary Connection"
  type        = string
  default     = ""
}
variable "zside_interface_type_sec" {
  description = "Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_interface_id_sec" {
  description = "Interface Id"
  type        = number
}
variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
}
