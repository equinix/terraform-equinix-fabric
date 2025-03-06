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
