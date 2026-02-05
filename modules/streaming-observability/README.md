# Fabric Streaming Observability SubModule

The Fabric Streaming Observability Module will:
1. Create a Fabric Stream
   * **NOTE: Fabric streams have a max limit of 3 subscriptions per stream.
     So if all subscriptions available in this module are leveraged then a 
     2nd Fabric Stream will be created to accommodate the extra subscriptions.
     This does have billing considerations to take into account as the 2nd
     Fabric Stream will be billed to your account as well**
2. Create Fabric Stream Subscriptions based on the variable values input into
   the module at creation
   * Available subscription types in this module at this time are:
     [Splunk, Slack, MicrosoftTeams, PagerDuty, Datadog]
3. Exposes outputs for each of the Fabric Resources created in this module
   * View outputs.tf file below for details on how the resource outputs are
     provided based on their creation

Please refer to the stream* examples in this module's registry for more details on how to leverage the submodule.

<!-- BEGIN_TF_DOCS -->
## Equinix Fabric Developer Documentation

To see the documentation for the APIs that the Fabric Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Fabric Developer Portal](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview)

## Modules File Content 

#versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 4.1.0"
    }
  }
}
```

#variables.tf
 ```hcl

variable "datadog_api_key" {
  description = "API Key for Datadog account"
  type        = string
  default     = ""
  sensitive   = true
}
variable "datadog_application_key" {
  description = "Application Key for Datadog App receiving the streaming messages"
  type        = string
  default     = ""
  sensitive   = true
}
variable "datadog_description" {
  description = "Description of the Datadog Subscription"
  type        = string
  default     = ""
}
variable "datadog_enabled" {
  description = "Boolean value enabling Datadog Subscription"
  type        = string
  default     = ""
}
variable "datadog_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "datadog_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "datadog_event_uri" {
  description = "Datadog App URI for receiving streamed events"
  type        = string
  default     = ""
}
variable "datadog_filters" {
  description = "Filters for the Datadog Subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "datadog_host" {
  description = "Datadog Sink Hostname"
  type        = string
  default     = ""
}
variable "datadog_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "datadog_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "datadog_metric_uri" {
  description = "Datadog App URI for receiving streamed metrics"
  type        = string
  default     = ""
}
variable "datadog_name" {
  description = "Name of the Datadog Subscription Equinix Resource"
  type        = string
  default     = ""
}
variable "msteams_description" {
  description = "Description for the MSTeams Subscription Resource"
  type        = string
  default     = ""
}
variable "msteams_enabled" {
  description = "Boolean value enabling MSTeams Sink Subscription"
  type        = string
  default     = ""
}
variable "msteams_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_filters" {
  description = "Filters for the events and metrics on the stream subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "msteams_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_name" {
  description = "Name of the MSTeams Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "msteams_uri" {
  description = "URI that the streaming messages will be sent to for MSTeams"
  type        = string
  default     = ""
  sensitive   = true
}
variable "pagerduty_alert_uri" {
  description = "URI for the streaming alerts to be sent to for PagerDuty"
  type        = string
  default     = ""
}
variable "pagerduty_change_uri" {
  description = "URI for the streaming events to be sent to for PagerDuty"
  type        = string
  default     = ""
}
variable "pagerduty_description" {
  description = "Description of the PagerDuty Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "pagerduty_enabled" {
  description = "Boolean value indicating enablment for the PagerDuty Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "pagerduty_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_filters" {
  description = "Filters for the events and metrics on the stream subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "pagerduty_host" {
  description = "Hostname for PagerDuty streaming messages destination"
  type        = string
  default     = ""
}
variable "pagerduty_integration_key" {
  description = "PagerDuty integration key value for authentication"
  type        = string
  default     = ""
  sensitive   = true
}
variable "pagerduty_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_name" {
  description = "Name of the PagerDuty Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "slack_enabled" {
  description = "Boolean value indicating enablement of the Slack Subscription Resource"
  type        = string
  default     = ""
}
variable "slack_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_filters" {
  description = "Filters for the events and metrics on the stream subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "slack_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_name" {
  description = "Name of the Slack Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "slack_description" {
  description = "Description of the Slack Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "slack_uri" {
  description = "URI for the Slack destination for the streaming messages"
  type        = string
  default     = ""
  sensitive   = true
}
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
variable "servicenow_name" {
  description = "Name of the Servicenow Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "servicenow_description" {
  description = "Description of the created stream(s) for servicenow in the module"
  type        = string
  default     = ""
}
variable "servicenow_enabled" {
  description = "Boolean value indicating enablement of the Splunk Subscription"
  type        = string
  default     = ""
}
variable "servicenow_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_host" {
  description = "Servicenow Sink Hostname"
  type        = string
  default     = ""
}
variable "servicenow_source" {
  description = "Name of the created Servicenow Source for the destination of the streaming messages"
  type        = string
  default     = ""
}
variable "servicenow_username" {
  description = "Username for Servicenow App"
  type        = string
  default     = ""
  sensitive   = true
}
variable "servicenow_password" {
  description = "Password for Servicenow App"
  type        = string
  default     = ""
  sensitive   = true
}
variable "webhook_event_uri" {
  description = "URI endpoint for webhook events"
  type        = string
  default     = ""
  sensitive   = true
}
variable "webhook_name" {
  description = "Name of the Webhook Equinix Subscription Resource"
  type        = string
  default     = "webhook-subscription"
}
variable "webhook_description" {
  description = "Description of the webhook subscription"
  type        = string
  default     = "Webhook stream subscription"
}
variable "webhook_enabled" {
  description = "Boolean value indicating enablement of the Webhook Subscription"
  type        = bool
  default     = true
}
variable "webhook_event_selections" {
  description = "List of event types to include for webhook"
  type        = list(string)
  default     = []
}
variable "webhook_event_exceptions" {
  description = "List of event types to exclude for webhook"
  type        = list(string)
  default     = []
}
variable "webhook_metric_selections" {
  description = "List of metric types to include for webhook"
  type        = list(string)
  default     = []
}
variable "webhook_metric_exceptions" {
  description = "List of metric types to exclude for webhook"
  type        = list(string)
  default     = []
}
variable "webhook_format" {
  description = "Format for webhook payload"
  type        = string
  default     = "JSON"
}
variable "webhook_metric_uri" {
  description = "URI endpoint for webhook metrics"
  type        = string
  default     = ""
  sensitive   = true
}
variable "grafana_event_uri" {
  description = "URI endpoint for grafana events"
  type        = string
  default     = ""
  sensitive   = true
}
variable "grafana_name" {
  description = "Name of the Grafana Equinix Subscription Resource"
  type        = string
  default     = "grafana-subscription"
}
variable "grafana_description" {
  description = "Description of the grafana subscription"
  type        = string
  default     = "Grafana stream subscription"
}
variable "grafana_enabled" {
  description = "Boolean value indicating enablement of the Grafana Subscription"
  type        = bool
  default     = true
}
variable "grafana_event_selections" {
  description = "List of event types to include for grafana"
  type        = list(string)
  default     = []
}
variable "grafana_event_exceptions" {
  description = "List of event types to exclude for grafana"
  type        = list(string)
  default     = []
}
variable "grafana_metric_selections" {
  description = "List of metric types to include for grafana"
  type        = list(string)
  default     = []
}
variable "grafana_metric_exceptions" {
  description = "List of metric types to exclude for grafana"
  type        = list(string)
  default     = []
}
variable "grafana_format" {
  description = "Format for grafana payload"
  type        = string
  default     = "JSON"
}
variable "grafana_metric_uri" {
  description = "URI endpoint for grafana metrics"
  type        = string
  default     = ""
  sensitive   = true
}
variable "project_id" {
  description = "Project ID where the streams will be created"
  type        = string
  default     = ""
}
```

 #outputs.tf
```hcl
output "first_stream" {
  value     = equinix_fabric_stream.stream1
  sensitive = true
}

output "second_stream" {
  value     = local.second_stream ? equinix_fabric_stream.stream2[0] : null
  sensitive = true
}

output "third_stream" {
  value     = local.third_stream ? equinix_fabric_stream.stream3[0] : null
  sensitive = true
}

output "splunk_subscription" {
  value     = var.splunk_uri != "" ? equinix_fabric_stream_subscription.splunk[0] : null
  sensitive = true
}

output "slack_subscription" {
  value     = var.slack_uri != "" ? equinix_fabric_stream_subscription.slack[0] : null
  sensitive = true
}

output "msteams_subscription" {
  value     = var.msteams_uri != "" ? equinix_fabric_stream_subscription.msteams[0] : null
  sensitive = true
}

output "pagerduty_subscription" {
  value     = var.pagerduty_host != "" ? equinix_fabric_stream_subscription.pagerduty[0] : null
  sensitive = true
}

output "datadog_subscription" {
  value     = var.datadog_host != "" ? equinix_fabric_stream_subscription.datadog[0] : null
  sensitive = true
}

output "servicenow_subscription" {
  value     = var.servicenow_host != "" ? equinix_fabric_stream_subscription.servicenow[0] : null
  sensitive = true
}

output "webhook_subscription" {
  value     = var.webhook_event_uri != "" ? equinix_fabric_stream_subscription.webhook[0] : null
  sensitive = true
}

output "grafana_subscription" {
  value     = var.grafana_event_uri != "" ? equinix_fabric_stream_subscription.grafana[0] : null
  sensitive = true
}
```

 #main.tf
```hcl

# Conditional logic determining if a second stream should be created to allow for the total count of subscriptions
locals {
  webhook_count = (var.webhook_event_uri != "" || var.webhook_metric_uri != "") ? 1 : 0
  grafana_count = (var.grafana_event_uri != "" || var.grafana_metric_uri != "") ? 1 : 0
  number_of_subscriptions = [
    for sub in [var.splunk_uri, var.slack_uri, var.pagerduty_host, var.msteams_uri, var.datadog_host, var.servicenow_host] : sub if sub != ""
  ]
  total_subscriptions = length(local.number_of_subscriptions) + local.webhook_count + local.grafana_count
  second_stream = local.total_subscriptions > 3 ? true : false
  third_stream  = local.total_subscriptions > 6 ? true : false

}

# Stream Creation -----------------------------------------------------
resource "equinix_fabric_stream" "stream1" {
  type        = "TELEMETRY_STREAM"
  name        = var.stream_name
  description = var.stream_description
  project = {
    project_id = var.project_id
  }
}

resource "equinix_fabric_stream" "stream2" {
  count       = local.second_stream ? 1 : 0
  type        = "TELEMETRY_STREAM"
  name        = join("-", [var.stream_name, "2"])
  description = var.stream_description
  project = {
    project_id = var.project_id
  }
}

resource "equinix_fabric_stream" "stream3" {
  count       = local.third_stream ? 1 : 0
  type        = "TELEMETRY_STREAM"
  name        = join("-", [var.stream_name, "3"])
  description = var.stream_description
  project = {
    project_id = var.project_id
  }
}

# Stream Subscription for Splunk --------------------------------------
resource "equinix_fabric_stream_subscription" "splunk" {
  count       = var.splunk_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.splunk_name
  description = var.splunk_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.splunk_enabled
  event_selector = {
    include = var.splunk_event_selections != [] ? var.splunk_event_selections : null
    except  = var.splunk_event_exceptions != [] ? var.splunk_event_exceptions : null
  }
  metric_selector = {
    include = var.splunk_metric_selections != [] ? var.splunk_metric_selections : null
    except  = var.splunk_metric_exceptions != [] ? var.splunk_metric_exceptions : null
  }
  sink = {
    type = "SPLUNK_HEC"
    uri  = var.splunk_uri
    settings = {
      source       = var.splunk_source
      event_index  = var.splunk_event_index
      metric_index = var.splunk_metric_index
    }
    credential = {
      type         = "ACCESS_TOKEN"
      access_token = var.splunk_access_token
    }
  }
}

# Stream Subscription for Slack --------------------------------------
resource "equinix_fabric_stream_subscription" "slack" {
  count       = var.slack_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.slack_name
  description = var.slack_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.slack_enabled
  event_selector = {
    include = var.slack_event_selections != [] ? var.slack_event_selections : null
    except  = var.slack_event_exceptions != [] ? var.slack_event_exceptions : null
  }
  metric_selector = {
    include = var.slack_metric_selections != [] ? var.slack_metric_selections : null
    except  = var.slack_metric_exceptions != [] ? var.slack_metric_exceptions : null
  }
  sink = {
    type = "SLACK"
    uri  = var.slack_uri
  }
}

# Stream Subscription for Pager Duty --------------------------------------
resource "equinix_fabric_stream_subscription" "pagerduty" {
  count       = var.pagerduty_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.pagerduty_name
  description = var.pagerduty_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.pagerduty_enabled
  event_selector = {
    include = var.pagerduty_event_selections != [] ? var.pagerduty_event_selections : null
    except  = var.pagerduty_event_exceptions != [] ? var.pagerduty_event_exceptions : null
  }
  metric_selector = {
    include = var.pagerduty_metric_selections != [] ? var.pagerduty_metric_selections : null
    except  = var.pagerduty_metric_exceptions != [] ? var.pagerduty_metric_exceptions : null
  }
  sink = {
    type = "PAGERDUTY"
    host = var.pagerduty_host
    settings = {
      change_uri = var.pagerduty_change_uri
      alert_uri  = var.pagerduty_alert_uri
    }
    credential = {
      type            = "INTEGRATION_KEY"
      integration_key = var.pagerduty_integration_key
    }
  }
}

# Stream Subscription for DataDog --------------------------------------
resource "equinix_fabric_stream_subscription" "datadog" {
  count       = var.datadog_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.datadog_name
  description = var.datadog_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled     = var.datadog_enabled
  event_selector = {
    include = var.datadog_event_selections != [] ? var.datadog_event_selections : null
    except  = var.datadog_event_exceptions != [] ? var.datadog_event_exceptions : null
  }
  metric_selector = {
    include = var.datadog_metric_selections != [] ? var.datadog_metric_selections : null
    except  = var.datadog_metric_exceptions != [] ? var.datadog_metric_exceptions : null
  }
  sink = {
    type = "DATADOG"
    host = var.datadog_host
    settings = {
      source          = "Equinix"
      application_key = var.datadog_application_key
      event_uri       = var.datadog_event_uri
      metric_uri      = var.datadog_metric_uri
    }
    credential = {
      type    = "API_KEY"
      api_key = var.datadog_api_key
    }
  }
}

# Stream Subscription for Microsoft Teams --------------------------------------
resource "equinix_fabric_stream_subscription" "msteams" {
  count       = var.msteams_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.msteams_name
  description = var.msteams_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled     = var.msteams_enabled
  event_selector = {
    include = var.msteams_event_selections != [] ? var.msteams_event_selections : null
    except  = var.msteams_event_exceptions != [] ? var.msteams_event_exceptions : null
  }
  metric_selector = {
    include = var.msteams_metric_selections != [] ? var.msteams_metric_selections : null
    except  = var.msteams_metric_exceptions != [] ? var.msteams_metric_exceptions : null
  }
  sink = {
    type = "TEAMS"
    uri  = var.msteams_uri
  }
}

# Stream Subscription for ServiceNow --------------------------------------
resource "equinix_fabric_stream_subscription" "servicenow" {
  count       = var.servicenow_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.servicenow_name
  description = var.servicenow_description
  stream_id = (local.third_stream ? equinix_fabric_stream.stream3[0].id :
      local.second_stream ? equinix_fabric_stream.stream2[0].id :
      equinix_fabric_stream.stream1.id)
  enabled     = var.servicenow_enabled
  event_selector = {
    include = var.servicenow_event_selections != [] ? var.servicenow_event_selections : null
    except  = var.servicenow_event_exceptions != [] ? var.servicenow_event_exceptions : null
  }
  metric_selector = {
    include = var.servicenow_metric_selections != [] ? var.servicenow_metric_selections : null
    except  = var.servicenow_metric_exceptions != [] ? var.servicenow_metric_exceptions : null
  }
  sink = {
    type = "SERVICENOW"
    host = var.servicenow_host
    settings = {
      source = var.servicenow_source
    }
    credential = {
      type = "USERNAME_PASSWORD"
      username = var.servicenow_username
      password = var. servicenow_password
    }
  }
}

# Stream Subscription for Webhook --------------------------------------
resource "equinix_fabric_stream_subscription" "webhook" {
  count       = local.webhook_count
  type        = "STREAM_SUBSCRIPTION"
  name        = var.webhook_name
  description = var.webhook_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled = var.webhook_enabled
  event_selector = {
    include = var.webhook_event_selections != [] ? var.webhook_event_selections : null
    except  = var.webhook_event_exceptions != [] ? var.webhook_event_exceptions : null
  }
  metric_selector = {
    include = var.webhook_metric_selections != [] ? var.webhook_metric_selections : null
    except  = var.webhook_metric_exceptions != [] ? var.webhook_metric_exceptions : null
  }
  sink = {
    type = "WEBHOOK"
    settings = {
      format     = var.webhook_format
      event_uri  = var.webhook_event_uri != "" ? var.webhook_event_uri : null
      metric_uri = var.webhook_metric_uri != "" ? var.webhook_metric_uri : null
    }
  }
}

# Stream Subscription for Grafana --------------------------------------
resource "equinix_fabric_stream_subscription" "grafana" {
  count       = local.grafana_count
  type        = "STREAM_SUBSCRIPTION"
  name        = var.grafana_name
  description = var.grafana_description
  stream_id = (local.third_stream ? equinix_fabric_stream.stream3[0].id :
      local.second_stream ? equinix_fabric_stream.stream2[0].id :
      equinix_fabric_stream.stream1.id)
  enabled     = var.grafana_enabled
  event_selector = {
    include = var.grafana_event_selections != [] ? var.grafana_event_selections : null
    except  = var.grafana_event_exceptions != [] ? var.grafana_event_exceptions : null
  }
  metric_selector = {
    include = var.grafana_metric_selections != [] ? var.grafana_metric_selections : null
    except  = var.grafana_metric_exceptions != [] ? var.grafana_metric_exceptions : null
  }
  sink = {
    type = "WEBHOOK"
    settings = {
      format     = var.grafana_format
      event_uri  = var.grafana_event_uri != "" ? var.grafana_event_uri : null
      metric_uri = var.grafana_metric_uri != "" ? var.grafana_metric_uri : null
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_stream.stream1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream) | resource |
| [equinix_fabric_stream.stream2](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream) | resource |
| [equinix_fabric_stream.stream3](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream) | resource |
| [equinix_fabric_stream_subscription.datadog](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.grafana](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.msteams](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.pagerduty](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.servicenow](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.slack](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.splunk](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |
| [equinix_fabric_stream_subscription.webhook](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | API Key for Datadog account | `string` | `""` | no |
| <a name="input_datadog_application_key"></a> [datadog\_application\_key](#input\_datadog\_application\_key) | Application Key for Datadog App receiving the streaming messages | `string` | `""` | no |
| <a name="input_datadog_description"></a> [datadog\_description](#input\_datadog\_description) | Description of the Datadog Subscription | `string` | `""` | no |
| <a name="input_datadog_enabled"></a> [datadog\_enabled](#input\_datadog\_enabled) | Boolean value enabling Datadog Subscription | `string` | `""` | no |
| <a name="input_datadog_event_exceptions"></a> [datadog\_event\_exceptions](#input\_datadog\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_datadog_event_selections"></a> [datadog\_event\_selections](#input\_datadog\_event\_selections) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_datadog_event_uri"></a> [datadog\_event\_uri](#input\_datadog\_event\_uri) | Datadog App URI for receiving streamed events | `string` | `""` | no |
| <a name="input_datadog_filters"></a> [datadog\_filters](#input\_datadog\_filters) | Filters for the Datadog Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_datadog_host"></a> [datadog\_host](#input\_datadog\_host) | Datadog Sink Hostname | `string` | `""` | no |
| <a name="input_datadog_metric_exceptions"></a> [datadog\_metric\_exceptions](#input\_datadog\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_datadog_metric_selections"></a> [datadog\_metric\_selections](#input\_datadog\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_datadog_metric_uri"></a> [datadog\_metric\_uri](#input\_datadog\_metric\_uri) | Datadog App URI for receiving streamed metrics | `string` | `""` | no |
| <a name="input_datadog_name"></a> [datadog\_name](#input\_datadog\_name) | Name of the Datadog Subscription Equinix Resource | `string` | `""` | no |
| <a name="input_grafana_description"></a> [grafana\_description](#input\_grafana\_description) | Description of the grafana subscription | `string` | `"Grafana stream subscription"` | no |
| <a name="input_grafana_enabled"></a> [grafana\_enabled](#input\_grafana\_enabled) | Boolean value indicating enablement of the Grafana Subscription | `bool` | `true` | no |
| <a name="input_grafana_event_exceptions"></a> [grafana\_event\_exceptions](#input\_grafana\_event\_exceptions) | List of event types to exclude for grafana | `list(string)` | `[]` | no |
| <a name="input_grafana_event_selections"></a> [grafana\_event\_selections](#input\_grafana\_event\_selections) | List of event types to include for grafana | `list(string)` | `[]` | no |
| <a name="input_grafana_event_uri"></a> [grafana\_event\_uri](#input\_grafana\_event\_uri) | URI endpoint for grafana events | `string` | `""` | no |
| <a name="input_grafana_format"></a> [grafana\_format](#input\_grafana\_format) | Format for grafana payload | `string` | `"JSON"` | no |
| <a name="input_grafana_metric_exceptions"></a> [grafana\_metric\_exceptions](#input\_grafana\_metric\_exceptions) | List of metric types to exclude for grafana | `list(string)` | `[]` | no |
| <a name="input_grafana_metric_selections"></a> [grafana\_metric\_selections](#input\_grafana\_metric\_selections) | List of metric types to include for grafana | `list(string)` | `[]` | no |
| <a name="input_grafana_metric_uri"></a> [grafana\_metric\_uri](#input\_grafana\_metric\_uri) | URI endpoint for grafana metrics | `string` | `""` | no |
| <a name="input_grafana_name"></a> [grafana\_name](#input\_grafana\_name) | Name of the Grafana Equinix Subscription Resource | `string` | `"grafana-subscription"` | no |
| <a name="input_msteams_description"></a> [msteams\_description](#input\_msteams\_description) | Description for the MSTeams Subscription Resource | `string` | `""` | no |
| <a name="input_msteams_enabled"></a> [msteams\_enabled](#input\_msteams\_enabled) | Boolean value enabling MSTeams Sink Subscription | `string` | `""` | no |
| <a name="input_msteams_event_exceptions"></a> [msteams\_event\_exceptions](#input\_msteams\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_event_selections"></a> [msteams\_event\_selections](#input\_msteams\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_filters"></a> [msteams\_filters](#input\_msteams\_filters) | Filters for the events and metrics on the stream subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_msteams_metric_exceptions"></a> [msteams\_metric\_exceptions](#input\_msteams\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_metric_selections"></a> [msteams\_metric\_selections](#input\_msteams\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_name"></a> [msteams\_name](#input\_msteams\_name) | Name of the MSTeams Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_msteams_uri"></a> [msteams\_uri](#input\_msteams\_uri) | URI that the streaming messages will be sent to for MSTeams | `string` | `""` | no |
| <a name="input_pagerduty_alert_uri"></a> [pagerduty\_alert\_uri](#input\_pagerduty\_alert\_uri) | URI for the streaming alerts to be sent to for PagerDuty | `string` | `""` | no |
| <a name="input_pagerduty_change_uri"></a> [pagerduty\_change\_uri](#input\_pagerduty\_change\_uri) | URI for the streaming events to be sent to for PagerDuty | `string` | `""` | no |
| <a name="input_pagerduty_description"></a> [pagerduty\_description](#input\_pagerduty\_description) | Description of the PagerDuty Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_pagerduty_enabled"></a> [pagerduty\_enabled](#input\_pagerduty\_enabled) | Boolean value indicating enablment for the PagerDuty Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_pagerduty_event_exceptions"></a> [pagerduty\_event\_exceptions](#input\_pagerduty\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_event_selections"></a> [pagerduty\_event\_selections](#input\_pagerduty\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_filters"></a> [pagerduty\_filters](#input\_pagerduty\_filters) | Filters for the events and metrics on the stream subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_pagerduty_host"></a> [pagerduty\_host](#input\_pagerduty\_host) | Hostname for PagerDuty streaming messages destination | `string` | `""` | no |
| <a name="input_pagerduty_integration_key"></a> [pagerduty\_integration\_key](#input\_pagerduty\_integration\_key) | PagerDuty integration key value for authentication | `string` | `""` | no |
| <a name="input_pagerduty_metric_exceptions"></a> [pagerduty\_metric\_exceptions](#input\_pagerduty\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_metric_selections"></a> [pagerduty\_metric\_selections](#input\_pagerduty\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_name"></a> [pagerduty\_name](#input\_pagerduty\_name) | Name of the PagerDuty Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the streams will be created | `string` | `""` | no |
| <a name="input_servicenow_description"></a> [servicenow\_description](#input\_servicenow\_description) | Description of the created stream(s) for servicenow in the module | `string` | `""` | no |
| <a name="input_servicenow_enabled"></a> [servicenow\_enabled](#input\_servicenow\_enabled) | Boolean value indicating enablement of the Splunk Subscription | `string` | `""` | no |
| <a name="input_servicenow_event_exceptions"></a> [servicenow\_event\_exceptions](#input\_servicenow\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_event_selections"></a> [servicenow\_event\_selections](#input\_servicenow\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_host"></a> [servicenow\_host](#input\_servicenow\_host) | Servicenow Sink Hostname | `string` | `""` | no |
| <a name="input_servicenow_metric_exceptions"></a> [servicenow\_metric\_exceptions](#input\_servicenow\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_metric_selections"></a> [servicenow\_metric\_selections](#input\_servicenow\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_name"></a> [servicenow\_name](#input\_servicenow\_name) | Name of the Servicenow Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_servicenow_password"></a> [servicenow\_password](#input\_servicenow\_password) | Password for Servicenow App | `string` | `""` | no |
| <a name="input_servicenow_source"></a> [servicenow\_source](#input\_servicenow\_source) | Name of the created Servicenow Source for the destination of the streaming messages | `string` | `""` | no |
| <a name="input_servicenow_username"></a> [servicenow\_username](#input\_servicenow\_username) | Username for Servicenow App | `string` | `""` | no |
| <a name="input_slack_description"></a> [slack\_description](#input\_slack\_description) | Description of the Slack Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_slack_enabled"></a> [slack\_enabled](#input\_slack\_enabled) | Boolean value indicating enablement of the Slack Subscription Resource | `string` | `""` | no |
| <a name="input_slack_event_exceptions"></a> [slack\_event\_exceptions](#input\_slack\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_event_selections"></a> [slack\_event\_selections](#input\_slack\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_filters"></a> [slack\_filters](#input\_slack\_filters) | Filters for the events and metrics on the stream subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_slack_metric_exceptions"></a> [slack\_metric\_exceptions](#input\_slack\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_metric_selections"></a> [slack\_metric\_selections](#input\_slack\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_name"></a> [slack\_name](#input\_slack\_name) | Name of the Slack Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_slack_uri"></a> [slack\_uri](#input\_slack\_uri) | URI for the Slack destination for the streaming messages | `string` | `""` | no |
| <a name="input_splunk_access_token"></a> [splunk\_access\_token](#input\_splunk\_access\_token) | Credential for Splunk Sink Subscription | `string` | `""` | no |
| <a name="input_splunk_description"></a> [splunk\_description](#input\_splunk\_description) | Description of the Splunk Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_splunk_enabled"></a> [splunk\_enabled](#input\_splunk\_enabled) | Boolean value indicating enablement of the Splunk Subscription | `string` | `""` | no |
| <a name="input_splunk_event_exceptions"></a> [splunk\_event\_exceptions](#input\_splunk\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_event_index"></a> [splunk\_event\_index](#input\_splunk\_event\_index) | Event index for the Splunk Sink Source | `string` | `""` | no |
| <a name="input_splunk_event_selections"></a> [splunk\_event\_selections](#input\_splunk\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_filters"></a> [splunk\_filters](#input\_splunk\_filters) | Filters for the events and metrics on the stream subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_splunk_metric_exceptions"></a> [splunk\_metric\_exceptions](#input\_splunk\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_metric_index"></a> [splunk\_metric\_index](#input\_splunk\_metric\_index) | Metric index for the Splunk Sink Source | `string` | `""` | no |
| <a name="input_splunk_metric_selections"></a> [splunk\_metric\_selections](#input\_splunk\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_name"></a> [splunk\_name](#input\_splunk\_name) | Name of the Splunk Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_splunk_source"></a> [splunk\_source](#input\_splunk\_source) | Name of the created Splunk Source for the destination of the streaming messages | `string` | `""` | no |
| <a name="input_splunk_uri"></a> [splunk\_uri](#input\_splunk\_uri) | URI for the streaming messages to be sent to for Splunk | `string` | `""` | no |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_webhook_description"></a> [webhook\_description](#input\_webhook\_description) | Description of the webhook subscription | `string` | `"Webhook stream subscription"` | no |
| <a name="input_webhook_enabled"></a> [webhook\_enabled](#input\_webhook\_enabled) | Boolean value indicating enablement of the Webhook Subscription | `bool` | `true` | no |
| <a name="input_webhook_event_exceptions"></a> [webhook\_event\_exceptions](#input\_webhook\_event\_exceptions) | List of event types to exclude for webhook | `list(string)` | `[]` | no |
| <a name="input_webhook_event_selections"></a> [webhook\_event\_selections](#input\_webhook\_event\_selections) | List of event types to include for webhook | `list(string)` | `[]` | no |
| <a name="input_webhook_event_uri"></a> [webhook\_event\_uri](#input\_webhook\_event\_uri) | URI endpoint for webhook events | `string` | `""` | no |
| <a name="input_webhook_format"></a> [webhook\_format](#input\_webhook\_format) | Format for webhook payload | `string` | `"JSON"` | no |
| <a name="input_webhook_metric_exceptions"></a> [webhook\_metric\_exceptions](#input\_webhook\_metric\_exceptions) | List of metric types to exclude for webhook | `list(string)` | `[]` | no |
| <a name="input_webhook_metric_selections"></a> [webhook\_metric\_selections](#input\_webhook\_metric\_selections) | List of metric types to include for webhook | `list(string)` | `[]` | no |
| <a name="input_webhook_metric_uri"></a> [webhook\_metric\_uri](#input\_webhook\_metric\_uri) | URI endpoint for webhook metrics | `string` | `""` | no |
| <a name="input_webhook_name"></a> [webhook\_name](#input\_webhook\_name) | Name of the Webhook Equinix Subscription Resource | `string` | `"webhook-subscription"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_subscription"></a> [datadog\_subscription](#output\_datadog\_subscription) | n/a |
| <a name="output_first_stream"></a> [first\_stream](#output\_first\_stream) | n/a |
| <a name="output_grafana_subscription"></a> [grafana\_subscription](#output\_grafana\_subscription) | n/a |
| <a name="output_msteams_subscription"></a> [msteams\_subscription](#output\_msteams\_subscription) | n/a |
| <a name="output_pagerduty_subscription"></a> [pagerduty\_subscription](#output\_pagerduty\_subscription) | n/a |
| <a name="output_second_stream"></a> [second\_stream](#output\_second\_stream) | n/a |
| <a name="output_servicenow_subscription"></a> [servicenow\_subscription](#output\_servicenow\_subscription) | n/a |
| <a name="output_slack_subscription"></a> [slack\_subscription](#output\_slack\_subscription) | n/a |
| <a name="output_splunk_subscription"></a> [splunk\_subscription](#output\_splunk\_subscription) | n/a |
| <a name="output_third_stream"></a> [third\_stream](#output\_third\_stream) | n/a |
| <a name="output_webhook_subscription"></a> [webhook\_subscription](#output\_webhook\_subscription) | n/a |
<!-- END_TF_DOCS -->
