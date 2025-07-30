
variable "splunk_access_token" {
  description = "Credential for Splunk Sink Subscription"
  type        = string
  default     = ""
  sensitive   = true
}
variable "splunk_description" {
  description = "Description of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "splunk_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_event_index" {
  description = "Event index for the Splunk Sink Source"
  type        = string
  default     = ""
}
variable "splunk_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_filters" {
  description = "Filters for the events and metrics on the stream subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "splunk_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_metric_index" {
  description = "Metric index for the Splunk Sink Source"
  type        = string
  default     = ""
}
variable "splunk_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_name" {
  description = "Name of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "splunk_source" {
  description = "Name of the created Splunk Source for the destination of the streaming messages"
  type        = string
  default     = ""
}
variable "splunk_uri" {
  description = "URI for the streaming messages to be sent to for Splunk"
  type        = string
  default     = ""
}
variable "splunk_enabled" {
  description = "Boolean value indicating enablement of the Splunk Subscription"
  type        = string
  default     = ""
}
variable "stream_description" {
  description = "Description of the created stream(s) in the module"
  type        = string
}
variable "stream_name" {
  description = "Name (and name prefix) for the created stream(s) in the module"
  type        = string
}
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