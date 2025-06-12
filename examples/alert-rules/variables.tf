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
variable "stream_name" {
  description = "Stream name"
  type        = string
}
variable "stream_description" {
  description = "Stream description"
  type        = string
}
variable "stream_type" {
  description = "Stream type"
  type        = string
}
variable "project_id" {
  description = "Project id"
  type        = string
}
variable "subscription_name" {
  description = "Stream name"
  type        = string
}
variable "subscription_description" {
  description = "Stream description"
  type        = string
}
variable "subscription_type" {
  description = "Stream subscription type"
  type        = string
}
variable "uri" {
  description = "Uri for Splunk"
  type        = string
}
variable "event_index" {
  description = "Event index for Splunk"
  type        = string
}
variable "metric_index" {
  description = "Metric index for Splunk"
  type        = string
}
variable "source_splunk" {
  description = "Source for Splunk data"
  type        = string
}
variable "access_token" {
  description = "Access token for Splunk"
  type        = string
  sensitive   = true
}
variable "alert_rule_name" {
  description = "Alert rule name"
  type        = string
}
variable "alert_rule_description" {
  description = "Alert rule description"
  type        = string
}
variable "window_size" {
  description = "Alert rule window size"
  type        = string
}
variable "warning_threshold" {
  description = "Alert rule warning threshold"
  type        = string
}
variable "critical_threshold" {
  description = "Alert rule critical threshold"
  type        = string
}
variable "metric_name" {
  description = "Metric Name for the alert rule"
  type        = string
}
variable "limit" {
  description = "Limit for alert rules data"
  type        = number
}
variable "offset" {
  description = "Offset for alert rule data"
  type        = number
}
