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
variable "stream_description" {
  description = "Description of the created stream(s) in the module"
  type = string
}
variable "stream_name" {
  description = "Name (and name prefix) for the created stream(s) in the module"
  type = string
}

variable "slack_uri" {
  description = "API Key for slack account"
  type = string
  default = ""
  sensitive = true
}
variable "slack_description" {
  description = "Description of the slack Subscription"
  type = string
  default = ""
}
variable "slack_enabled" {
  description = "Boolean value enabling slack Subscription"
  type = string
  default = ""
}
variable "slack_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "slack_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "slack_filters" {
  description = "Filters for the slack Subscription"
  type        = list(object({
    property = string,
    operator = string,
    values = list(string),
    or = optional(bool),
  }))
  default = []
}
variable "slack_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "slack_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "slack_name" {
  description = "Name of the slack Subscription Equinix Resource"
  type = string
  default = ""
}

variable "msteams_description" {
  description = "Description of the Microsoft Teams Subscription"
  type = string
  default = ""
}
variable "msteams_enabled" {
  description = "Boolean value enabling Microsoft Teams Subscription"
  type = string
  default = ""
}
variable "msteams_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "msteams_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "msteams_filters" {
  description = "Filters for the Microsoft Teams Subscription"
  type        = list(object({
    property = string,
    operator = string,
    values = list(string),
    or = optional(bool),
  }))
  default = []
}
variable "msteams_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "msteams_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "msteams_name" {
  description = "Name of the Microsoft Teams Subscription Equinix Resource"
  type = string
  default = ""
}
variable "msteams_uri" {
  description = "Microsoft Teams URI for destination of streaming messages"
  type = string
  default = ""
  sensitive = true
}

variable "splunk_access_token" {
  description = "Credential for Splunk Sink Subscription"
  type = string
  default = ""
  sensitive = true
}
variable "splunk_description" {
  description = "Description of the Splunk Equinix Subscription Resource"
  type = string
  default = ""
}
variable "splunk_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "splunk_event_index" {
  description = "Event index for the Splunk Sink Source"
  type = string
  default = ""
}
variable "splunk_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "splunk_filters" {
  description = "Filters for the events and metrics on the stream subscription"
  type        = list(object({
    property = string,
    operator = string,
    values = list(string),
    or = optional(bool),
  }))
  default = []
}
variable "splunk_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "splunk_metric_index" {
  description = "Metric index for the Splunk Sink Source"
  type = string
  default = ""
}
variable "splunk_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "splunk_name" {
  description = "Name of the Splunk Equinix Subscription Resource"
  type = string
  default = ""
}
variable "splunk_source" {
  description = "Name of the created Splunk Source for the destination of the streaming messages"
  type = string
  default = ""
}
variable "splunk_uri" {
  description = "URI for the streaming messages to be sent to for Splunk"
  type = string
  default = ""
}
variable "splunk_enabled" {
  description = "Boolean value indicating enablement of the Splunk Subscription"
  type = string
  default = ""
}

variable "pagerduty_integration_key" {
  description = "Application Key for PagerDuty App receiving the streaming messages"
  type = string
  default = ""
  sensitive = true
}
variable "pagerduty_description" {
  description = "Description of the PagerDuty Subscription"
  type = string
  default = ""
}
variable "pagerduty_enabled" {
  description = "Boolean value enabling PagerDuty Subscription"
  type = string
  default = ""
}
variable "pagerduty_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "pagerduty_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "pagerduty_change_uri" {
  description = "PagerDuty App URI for receiving streamed changes"
  type = string
  default = ""
}
variable "pagerduty_filters" {
  description = "Filters for the PagerDuty Subscription"
  type        = list(object({
    property = string,
    operator = string,
    values = list(string),
    or = optional(bool),
  }))
  default = []
}
variable "pagerduty_host" {
  description = "PagerDuty Sink Hostname"
  type = string
  default = ""
}
variable "pagerduty_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "pagerduty_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "pagerduty_alert_uri" {
  description = "PagerDuty App URI for receiving streamed alerts"
  type = string
  default = ""
}
variable "pagerduty_name" {
  description = "Name of the PagerDuty Subscription Equinix Resource"
  type = string
  default = ""
}

variable "datadog_api_key" {
  description = "API Key for Datadog account"
  type = string
  default = ""
  sensitive = true
}
variable "datadog_application_key" {
  description = "Application Key for Datadog App receiving the streaming messages"
  type = string
  default = ""
  sensitive = true
}
variable "datadog_description" {
  description = "Description of the Datadog Subscription"
  type = string
  default = ""
}
variable "datadog_enabled" {
  description = "Boolean value enabling Datadog Subscription"
  type = string
  default = ""
}
variable "datadog_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "datadog_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "datadog_event_uri" {
  description = "Datadog App URI for receiving streamed events"
  type = string
  default = ""
}
variable "datadog_filters" {
  description = "Filters for the Datadog Subscription"
  type        = list(object({
    property = string,
    operator = string,
    values = list(string),
    or = optional(bool),
  }))
  default = []
}
variable "datadog_host" {
  description = "Datadog Sink Hostname"
  type = string
  default = ""
}
variable "datadog_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "datadog_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type = list(string)
  default = []
}
variable "datadog_metric_uri" {
  description = "Datadog App URI for receiving streamed metrics"
  type = string
  default = ""
}
variable "datadog_name" {
  description = "Name of the Datadog Subscription Equinix Resource"
  type = string
  default = ""
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
