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
