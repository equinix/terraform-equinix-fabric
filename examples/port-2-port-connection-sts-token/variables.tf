variable "sts_source_token" {
  description = "Equinix STS Source Token, the ID token generated using: python -m oidcsim idtoken --sub {username}"
  type        = string
  sensitive   = true
}
variable "sts_auth_scope" {
  description = "Equinix STS Source Token Authentication Scope in the format: roleassignments:{rootOrg}"
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
variable "aside_port_uuid" {
  description = "Equinix A-Side Port UUID"
  type        = string
  default = ""
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
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_port_uuid" {
  description = "Equinix Port UUID"
  type        = string
  default     = ""
}
variable "zside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
