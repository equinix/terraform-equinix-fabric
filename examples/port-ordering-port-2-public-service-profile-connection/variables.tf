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
  description = "Order number"
  type        = string
  default     = ""
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
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
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "physical_ports_type" {
  description = "Physical ports type"
  type        = string
  default     = "1000BASE_LX"
}
variable "physical_ports_speed" {
  description = "Physical ports speed"
  type        = number
  default     = 1000
}

variable "connectivity_source_type" {
  description = "Connectivity source type"
  type        = string
  default     = "COLO"
}
variable "account_number" {
  description = "Account number"
  type        = string
}
variable "metro_code" {
  description = "Metro code"
  type        = string
}
variable "ibx" {
  description = "IBX"
  type        = string
}
variable "demarcation_point_ibx" {
  description = "Demarcation point IBX"
  type        = string
}
variable "cage_unique_space_id" {
  description = "Cage unique space ID"
  type        = string
}
variable "cabinet_unique_space_id" {
  description = "Cabinet unique space ID"
  type        = string
}
variable "patch_panel" {
  description = "Patch panel"
  type        = string
}
variable "project_id" {
  description = "Project ID"
  type        = string
}
variable "registered_user" {
  description = "Registered user for notifications"
  type        = string
}
variable "interface_type" {
  description = "Interface type"
  type        = string
}
variable "device_name" {
  description = "Device Name"
  type        = string
}
