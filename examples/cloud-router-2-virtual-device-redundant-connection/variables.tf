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
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "VD"
}
variable "zside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
variable "zside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_interface_type" {
  description = "Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_interface_id" {
  description = "Interface Id"
  type        = number
  default     = null
}
variable "secondary_connection_name" {
  description = "Secondary Connection name"
  type        = string
}
variable "secondary_bandwidth" {
  description = "Secondary Connection bandwidth in Mbps"
  type        = number
  default     = 50
}
variable "zside_sec_vd_uuid" {
  description = "Secondary Virtual Device UUID"
  type        = string
}
variable "zside_sec_interface_type" {
  description = "Secondary Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_sec_interface_id" {
  description = "Secondary Interface Id"
  type        = number
  default     = null
}
