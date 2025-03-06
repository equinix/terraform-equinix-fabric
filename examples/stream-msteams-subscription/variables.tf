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
