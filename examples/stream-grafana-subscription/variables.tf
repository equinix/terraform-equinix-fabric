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
  type        = string
}
variable "stream_name" {
  description = "Name (and name prefix) for the created stream(s) in the module"
  type        = string
}
variable "grafana_event_uri" {
  description = "URI for the streaming messages to be sent to for grafana"
  type        = string
}
variable "grafana_metric_uri" {
  description = "URI for the streaming messages to be sent to for grafana"
  type        = string
}
variable "grafana_name" {
  description = "Name of the grafana Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "grafana_description" {
  description = "Description for the grafana Subscription Resource"
  type        = string
  default     = ""
}
variable "grafana_enabled" {
  description = "Boolean value enabling grafana Sink Subscription"
  type        = string
  default     = ""
}
variable "grafana_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_host" {
  description = "grafana Host for the streaming messages destination"
  type        = string
  default     = ""
}
variable "grafana_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_metric_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_metric_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_format" {
  description = "Format for grafana payload"
  type        = string
  default     = "JSON"
}
variable "grafana_filters" {
  description = "Filters for the Grafana Subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}

