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
variable "webhook_event_uri" {
  description = "URI for the streaming messages to be sent to for webhook"
  type        = string
}
variable "webhook_metric_uri" {
  description = "URI for the streaming messages to be sent to for webhook"
  type        = string
}
variable "webhook_name" {
  description = "Name of the webhook Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "webhook_description" {
  description = "Description for the webhook Subscription Resource"
  type        = string
  default     = ""
}
variable "webhook_enabled" {
  description = "Boolean value enabling webhook Sink Subscription"
  type        = string
  default     = ""
}
variable "webhook_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "webhook_host" {
  description = "Webhook Host for the streaming messages destination"
  type        = string
  default     = ""
}
variable "webhook_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "webhook_metric_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "webhook_metric_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "webhook_format" {
  description = "Format of the webhook messages"
  type        = string
  default     = ""
}
variable "webhook_filters" {
  description = "Filters for the Servicenow Subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}

