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
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC, IA_VC"
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
  default     = 50
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
}
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
variable "aside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - NETWORK"
  type        = string
}
variable "zside_network_uuid" {
  description = "Access point network UUID"
  type        = string
}
variable "project_id" {
  description = "Project ID"
  type        = string
}
