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
variable "stream_name" {
  description = "Stream name"
  type        = string
}
variable "stream_description" {
  description = "Stream description"
  type        = string
}
variable "splunk_enabled" {
  description = "Boolean value indicating enablement of the Splunk Subscription"
  type        = bool
  default     = true
}
variable "splunk_access_token" {
  description = "Credential for Splunk Sink Subscription"
  type        = string
  default     = ""
  sensitive   = true
}
variable "splunk_name" {
  description = "Name of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "splunk_description" {
  description = "Description of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}

variable "splunk_uri" {
  description = "URI for the streaming messages to be sent to for Splunk"
  type        = string
  default     = ""
}
variable "splunk_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_source" {
  description = "Name of the created Splunk Source for the destination of the streaming messages"
  type        = string
  default     = ""
}
variable "splunk_event_index" {
  description = "Event index for the Splunk Sink Source"
  type        = string
  default     = ""
}
variable "splunk_metric_index" {
  description = "Metric index for Splunk Sink Source"
  type        = string
  default     = ""
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
  description = "Vlan tag for DOT1Q or QINQ connections"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_port_name" {
  description = "Equinix Port Name"
  type        = string
}
variable "zside_vlan_tag" {
  description = "Vlan tag for DOT1Q or QINQ connections"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "asset_type" {
  description = "Asset type"
  type        = string
}
variable "alert_rule_name" {
  description = "Alert rule name"
  type        = string
}
variable "alert_rule_description" {
  description = "Alert rule description"
  type        = string
}
variable "operand" {
  description = "Operand for the alert rule"
  type        = string
}
variable "window_size" {
  description = "Alert rule window size"
  type        = string
}
variable "warning_threshold" {
  description = "Warning threshold for the alert rule"
  type        = string
}
variable "critical_threshold" {
  description = "Critical threshold for the alert rule"
  type        = string
}
variable "metric_name" {
  description = "Metric Name for the alert rule"
  type        = string
}
variable "limit" {
  description = "Limit for pagination of alert rules"
  type        = number
}
variable "offset" {
  description = "Offset for pagination of alert rules"
  type        = number
}