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
variable "precision_time_ptp_name" {
  description = "Precision Time Service Name"
  type        = string
}
variable "precision_time_ptp_description" {
  description = "Precision Time Service Description"
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
variable "precision_time_advance_configuration_ptp_timescale" {
  description = "Precision Time Service PTP Advance Configuration Time Scale"
  type = string
  default = null
}
variable "precision_time_advance_configuration_ptp_domain" {
  description = "Precision Time Service PTP Advance Configuration Domain"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_priority_1" {
  description = "Precision Time Service PTP Advance Configuration Priority 1"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_priority_2" {
  description = "Precision Time Service PTP Advance Configuration Priority 2"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_log_announce_interval" {
  description = "Precision Time Service PTP Advance Configuration log_announce_interval"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_log_sync_interval" {
  description = "Precision Time Service PTP Advance Configuration log_sync_interval"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_log_delay_req_interval" {
  description = "Precision Time Service PTP Advance Configuration log_delay_req_interval"
  type = number
  default = null
}
variable "precision_time_advance_configuration_ptp_transport_mode" {
  description = "Precision Time Service PTP Advance Configuration transport_mode"
  type = string
  default = null
}
variable "precision_time_advance_configuration_ptp_grant_time" {
  description = "Precision Time Service PTP Advance Configuration grant_time"
  type = number
  default = null
}
