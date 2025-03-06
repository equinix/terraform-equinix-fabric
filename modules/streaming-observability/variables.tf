
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
variable "msteams_description" {
	description = "Description for the MSTeams Subscription Resource"
	type = string
	default = ""
}
variable "msteams_enabled" {
	description = "Boolean value enabling MSTeams Sink Subscription"
	type = string
	default = ""
}
variable "msteams_event_exceptions" {
	description = "Events to exclude from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "msteams_event_selections" {
	description = "Events to include from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "msteams_filters" {
	description = "Filters for the events and metrics on the stream subscription"
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
	description = "Name of the MSTeams Equinix Subscription Resource"
	type = string
	default = ""
}
variable "msteams_uri" {
	description = "URI that the streaming messages will be sent to for MSTeams"
	type = string
	default = ""
	sensitive = true
}
variable "pagerduty_alert_uri" {
	description = "URI for the streaming alerts to be sent to for PagerDuty"
	type = string
	default = ""
}
variable "pagerduty_change_uri" {
	description = "URI for the streaming events to be sent to for PagerDuty"
	type = string
	default = ""
}
variable "pagerduty_description" {
	description = "Description of the PagerDuty Equinix Subscription Resource"
	type = string
	default = ""
}
variable "pagerduty_enabled" {
	description = "Boolean value indicating enablment for the PagerDuty Equinix Subscription Resource"
	type = string
	default = ""
}
variable "pagerduty_event_exceptions" {
	description = "Events to exclude from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "pagerduty_event_selections" {
	description = "Events to include from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "pagerduty_filters" {
	description = "Filters for the events and metrics on the stream subscription"
	type        = list(object({
		property = string,
		operator = string,
		values = list(string),
		or = optional(bool),
	}))
	default = []
}
variable "pagerduty_host" {
	description = "Hostname for PagerDuty streaming messages destination"
	type = string
	default = ""
}
variable "pagerduty_integration_key" {
	description = "PagerDuty integration key value for authentication"
	type = string
	default = ""
	sensitive = true
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
variable "pagerduty_name" {
	description = "Name of the PagerDuty Equinix Subscription Resource"
	type = string
	default = ""
}
variable "slack_enabled" {
	description = "Boolean value indicating enablement of the Slack Subscription Resource"
	type = string
	default = ""
}
variable "slack_event_exceptions" {
	description = "Events to exclude from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "slack_event_selections" {
	description = "Events to include from the possibilities available to the stream for the Subscription"
	type = list(string)
	default = []
}
variable "slack_filters" {
	description = "Filters for the events and metrics on the stream subscription"
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
	description = "Name of the Slack Equinix Subscription Resource"
	type = string
	default = ""
}
variable "slack_description" {
	description = "Description of the Slack Equinix Subscription Resource"
	type = string
	default = ""
}
variable "slack_uri" {
	description = "URI for the Slack destination for the streaming messages"
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
variable "stream_description" {
	description = "Description of the created stream(s) in the module"
	type = string
}
variable "stream_name" {
	description = "Name (and name prefix) for the created stream(s) in the module"
	type = string
}
