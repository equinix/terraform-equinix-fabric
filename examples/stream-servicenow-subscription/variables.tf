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
variable "servicenow_uri" {
  description = "URI for the streaming messages to be sent to for ServiceNow"
  type        = string
  default     = ""
}
variable "servicenow_name" {
  description = "Name of the ServiceNow Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "servicenow_description" {
  description = "Description for the ServiceNow Subscription Resource"
  type        = string
  default     = ""
}
variable "servicenow_enabled" {
  description = "Boolean value enabling ServiceNow Sink Subscription"
  type        = string
  default     = ""
}
variable "servicenow_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_host" {
  description = "ServiceNow Host for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_username" {
  description = "ServiceNow Username for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_password" {
  description = "ServiceNow Password for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_filters" {
  description = "Filters for the Servicenow Subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}


