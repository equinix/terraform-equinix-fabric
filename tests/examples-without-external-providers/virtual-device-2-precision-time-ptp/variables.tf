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
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
variable "aside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_port_name" {
  description = "Equinix Port Name"
  type        = string
}
variable "zside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
variable "precision_time_ptp_name" {
  description = "Precision Time Service Name"
  type        = string
}
variable "precision_time_ptp_package_code" {
  description = "Precision Time Service Package Code"
  type        = string
}
variable "precision_time_ptp_ipv4_primary" {
  description = "Precision Time Service Primary Ipv4 value"
  type        = string
}
variable "precision_time_ptp_ipv4_secondary" {
  description = "Precision Time Service Secondary Ipv4 value"
  type        = string
}
variable "precision_time_ptp_ipv4_network_mask" {
  description = "Precision Time Service Ipv4 Network Mask value"
  type        = string
}
variable "precision_time_ptp_ipv4_default_gateway" {
  description = "Precision Time Service Ipv4 Default Gateway value"
  type        = string
}

variable "precision_time_ptp_advance_configuration" {
  description = "Precision Time Service PTP Advance Configuration Details"
  type = object({
    time_scale             = string
    domain                 = number
    priority1              = number
    priority2              = number
    log_announce_interval  = number
    log_sync_interval      = number
    log_delay_req_interval = number
    transport_mode         = string
    grant_time             = number
  })
  default = null
}
