# Fabric Stream and Stream Subscription - Datadog Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Datadog Fabric Stream Subscription.

It leverages the Equinix Terraform Provider and the Fabric Stream Module
to set up the stream and subscription based on the parameters you have provided to
this example. Additionally, the patterns found in this example can be followed in
your own custom Terraform configurations for more complex solutions.

See example usage below for details on how to use this example.

<!-- BEGIN_TF_DOCS -->
## Equinix Fabric Developer Documentation

To see the documentation for the APIs that the Fabric Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Fabric Developer Portal](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview)

## Usage of Example as Terraform Module

To provision this example directly as a usable module please use the *Provision Instructions* provided by Hashicorp
in the upper right of this page and be sure to include at a minimum the required variables.

## Usage of Example Locally or in Your Own Configuration

*Note:* This example creates resources which cost money. Run 'terraform destroy' when you don't need these resources.

To provision this example directly,
you should clone the github repository for this module and run terraform within this directory:

```bash
git clone https://github.com/equinix/terraform-equinix-fabric.git
cd terraform-equinix-fabric/examples/stream-multiple-subscriptions-with-port-connection-attachment
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id     = "<MyEquinixClientId>"
equinix_client_secret = "<MyEquinixSecret>"

stream_name        = "EmergingNetworksStream"
stream_description = "Source for Equinix Events/Metrics/Alerts"

slack_name        = "slackSub"
slack_description = "Destination for Equinix Events/Metrics/Alerts"
slack_enabled     = true
slack_uri         = "<customer_specific_uri>"
slack_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
slack_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
slack_event_selections  = ["equinix.fabric.router.*"]
slack_metric_exceptions = ["equinix.fabric.connection.*"]
slack_metric_selections = ["equinix.fabric.port.*"]

msteams_name        = "Microsoft Teams Sub"
msteams_description = "Destination for Equinix Events/Metrics/Alerts"
msteams_enabled     = true
msteams_uri         = "<customer_specific_uri>"
msteams_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
msteams_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
msteams_event_selections  = ["equinix.fabric.router.*"]
msteams_metric_exceptions = ["equinix.fabric.connection.*"]
msteams_metric_selections = ["equinix.fabric.port.*"]

splunk_name         = "splunkSub"
splunk_description  = "Destination for Equinix Events/Metrics/Alerts"
splunk_enabled      = true
splunk_uri          = "<customer_specific_uri>"
splunk_access_token = "<customer_splunk_access_token"
splunk_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
splunk_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
splunk_event_selections  = ["equinix.fabric.router.*"]
splunk_metric_exceptions = ["equinix.fabric.connection.*"]
splunk_metric_selections = ["equinix.fabric.port.*"]
splunk_source            = "<splunk_source>"
splunk_event_index       = "<splunk_event_index>"
splunk_metric_index      = "<splunk_metric_index>"

pagerduty_name            = "pagerdutySub"
pagerduty_description     = "Destination for Equinix Events/Metrics/Alerts"
pagerduty_enabled         = true
pagerduty_host            = "<customer_specific_host>"
pagerduty_integration_key = "<pagerduty_integration_key>"
pagerduty_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
pagerduty_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
pagerduty_event_selections  = ["equinix.fabric.router.*"]
pagerduty_metric_exceptions = ["equinix.fabric.connection.*"]
pagerduty_metric_selections = ["equinix.fabric.port.*"]
pagerduty_change_uri        = "<pagerduty_change_uri>"
pagerduty_alert_uri         = "<pagerduty_alert_uri>"

datadog_name            = "DatadogSub"
datadog_description     = "Destination for Equinix Events/Metrics/Alerts"
datadog_enabled         = true
datadog_host            = "<customer_specific_host>"
datadog_api_key         = "<datadog_api_key>"
datadog_application_key = "<datadog_application_key>"
datadog_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
datadog_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
datadog_event_selections  = ["equinix.fabric.router.*"]
datadog_metric_exceptions = ["equinix.fabric.connection.*"]
datadog_metric_selections = ["equinix.fabric.port.*"]
datadog_event_uri         = "<datadog_event_uri>"
datadog_metric_uri        = "<datadog_metric_uri>"

connection_name       = "Port2Port"
connection_type       = "EVPL_VC"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com", "test1@equinix.com"]
bandwidth             = 50
purchase_order_number = "1-323292"
aside_port_name       = "ops-user100-CX-SV5-NL-Qinq-STD-1G-SEC-JP-190"
aside_vlan_tag        = "1976"
zside_ap_type         = "COLO"
zside_port_name       = "ops-user100-CX-SV1-NL-Qinq-STD-1G-PRI-NK-349"
zside_vlan_tag        = "3711"
zside_location        = "SV"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 3.4.0"
    }
  }
}
```

variables.tf
 ```hcl
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

variable "slack_uri" {
  description = "API Key for slack account"
  type        = string
  default     = ""
  sensitive   = true
}
variable "slack_description" {
  description = "Description of the slack Subscription"
  type        = string
  default     = ""
}
variable "slack_enabled" {
  description = "Boolean value enabling slack Subscription"
  type        = string
  default     = ""
}
variable "slack_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "slack_filters" {
  description = "Filters for the slack Subscription"
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
  description = "Name of the slack Subscription Equinix Resource"
  type        = string
  default     = ""
}

variable "msteams_description" {
  description = "Description of the Microsoft Teams Subscription"
  type        = string
  default     = ""
}
variable "msteams_enabled" {
  description = "Boolean value enabling Microsoft Teams Subscription"
  type        = string
  default     = ""
}
variable "msteams_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "msteams_filters" {
  description = "Filters for the Microsoft Teams Subscription"
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
  description = "Name of the Microsoft Teams Subscription Equinix Resource"
  type        = string
  default     = ""
}
variable "msteams_uri" {
  description = "Microsoft Teams URI for destination of streaming messages"
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

variable "pagerduty_integration_key" {
  description = "Application Key for PagerDuty App receiving the streaming messages"
  type        = string
  default     = ""
  sensitive   = true
}
variable "pagerduty_description" {
  description = "Description of the PagerDuty Subscription"
  type        = string
  default     = ""
}
variable "pagerduty_enabled" {
  description = "Boolean value enabling PagerDuty Subscription"
  type        = string
  default     = ""
}
variable "pagerduty_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_event_selections" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "pagerduty_change_uri" {
  description = "PagerDuty App URI for receiving streamed changes"
  type        = string
  default     = ""
}
variable "pagerduty_filters" {
  description = "Filters for the PagerDuty Subscription"
  type = list(object({
    property = string,
    operator = string,
    values   = list(string),
    or       = optional(bool),
  }))
  default = []
}
variable "pagerduty_host" {
  description = "PagerDuty Sink Hostname"
  type        = string
  default     = ""
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
variable "pagerduty_alert_uri" {
  description = "PagerDuty App URI for receiving streamed alerts"
  type        = string
  default     = ""
}
variable "pagerduty_name" {
  description = "Name of the PagerDuty Subscription Equinix Resource"
  type        = string
  default     = ""
}

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
```

outputs.tf
```hcl
output "first_stream" {
  value     = module.stream_subscriptions.first_stream
  sensitive = true
}

output "second_stream" {
  value     = module.stream_subscriptions.second_stream
  sensitive = true
}

output "splunk_subscription" {
  value     = module.stream_subscriptions.splunk_subscription
  sensitive = true
}

output "slack_subscription" {
  value     = module.stream_subscriptions.slack_subscription
  sensitive = true
}

output "msteams_subscription" {
  value     = module.stream_subscriptions.msteams_subscription
  sensitive = true
}

output "pagerduty_subscription" {
  value     = module.stream_subscriptions.pagerduty_subscription
  sensitive = true
}

output "datadog_subscription" {
  value     = module.stream_subscriptions.datadog_subscription
  sensitive = true
}

output "port_connection" {
  value     = module.create_port_2_port_connection.primary_connection
  sensitive = true
}

output "port_attachment_on_first_stream" {
  value     = equinix_fabric_stream_attachment.port_connection_on_stream1
  sensitive = true
}

output "port_attachment_on_second_stream" {
  value     = equinix_fabric_stream_attachment.port_connection_on_stream2
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_subscriptions" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  slack_name              = var.slack_name
  slack_description       = var.slack_description
  slack_enabled           = var.slack_enabled
  slack_uri               = var.slack_uri
  slack_filters           = var.slack_filters
  slack_event_exceptions  = var.slack_event_exceptions
  slack_event_selections  = var.slack_event_selections
  slack_metric_exceptions = var.slack_metric_exceptions
  slack_metric_selections = var.slack_metric_selections

  splunk_enabled           = var.splunk_enabled
  splunk_access_token      = var.splunk_access_token
  splunk_name              = var.splunk_name
  splunk_description       = var.splunk_description
  splunk_uri               = var.splunk_uri
  splunk_filters           = var.splunk_filters
  splunk_event_exceptions  = var.splunk_event_exceptions
  splunk_event_selections  = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source            = var.splunk_source
  splunk_event_index       = var.splunk_event_index
  splunk_metric_index      = var.splunk_metric_index

  msteams_name              = var.msteams_name
  msteams_description       = var.msteams_description
  msteams_enabled           = var.msteams_enabled
  msteams_uri               = var.msteams_uri
  msteams_filters           = var.msteams_filters
  msteams_event_exceptions  = var.msteams_event_exceptions
  msteams_event_selections  = var.msteams_event_selections
  msteams_metric_exceptions = var.msteams_metric_exceptions
  msteams_metric_selections = var.msteams_metric_selections

  pagerduty_name              = var.pagerduty_name
  pagerduty_description       = var.pagerduty_description
  pagerduty_enabled           = var.pagerduty_enabled
  pagerduty_host              = var.pagerduty_host
  pagerduty_integration_key   = var.pagerduty_integration_key
  pagerduty_filters           = var.pagerduty_filters
  pagerduty_event_exceptions  = var.pagerduty_event_exceptions
  pagerduty_event_selections  = var.pagerduty_event_selections
  pagerduty_metric_exceptions = var.pagerduty_metric_exceptions
  pagerduty_metric_selections = var.pagerduty_metric_selections
  pagerduty_change_uri        = var.pagerduty_change_uri
  pagerduty_alert_uri         = var.pagerduty_alert_uri

  datadog_name              = var.datadog_name
  datadog_description       = var.datadog_description
  datadog_enabled           = var.datadog_enabled
  datadog_host              = var.datadog_host
  datadog_api_key           = var.datadog_api_key
  datadog_application_key   = var.datadog_application_key
  datadog_filters           = var.datadog_filters
  datadog_event_exceptions  = var.datadog_event_exceptions
  datadog_event_selections  = var.datadog_event_selections
  datadog_metric_exceptions = var.datadog_metric_exceptions
  datadog_metric_selections = var.datadog_metric_selections
  datadog_event_uri         = var.datadog_event_uri
  datadog_metric_uri        = var.datadog_metric_uri
}

module "create_port_2_port_connection" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type   = var.zside_ap_type
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
  zside_location  = var.zside_location
}

resource "equinix_fabric_stream_attachment" "port_connection_on_stream1" {
  asset_id  = module.create_port_2_port_connection.primary_connection_id
  asset     = "connections"
  stream_id = module.stream_subscriptions.first_stream.id
}

# Second Aatachment must happen on second stream in module to handle the max subscription per stream limitation
resource "equinix_fabric_stream_attachment" "port_connection_on_stream2" {
  asset_id  = module.create_port_2_port_connection.primary_connection_id
  asset     = "connections"
  stream_id = module.stream_subscriptions.second_stream.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 3.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_port_connection"></a> [create\_port\_2\_port\_connection](#module\_create\_port\_2\_port\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |
| <a name="module_stream_subscriptions"></a> [stream\_subscriptions](#module\_stream\_subscriptions) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_stream_attachment.port_connection_on_stream1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_attachment) | resource |
| [equinix_fabric_stream_attachment.port_connection_on_stream2](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_vlan_inner_tag"></a> [aside\_vlan\_inner\_tag](#input\_aside\_vlan\_inner\_tag) | Vlan Inner Tag information, inner vlanCTag for QINQ connections | `string` | `""` | no |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
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
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_msteams_description"></a> [msteams\_description](#input\_msteams\_description) | Description of the Microsoft Teams Subscription | `string` | `""` | no |
| <a name="input_msteams_enabled"></a> [msteams\_enabled](#input\_msteams\_enabled) | Boolean value enabling Microsoft Teams Subscription | `string` | `""` | no |
| <a name="input_msteams_event_exceptions"></a> [msteams\_event\_exceptions](#input\_msteams\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_event_selections"></a> [msteams\_event\_selections](#input\_msteams\_event\_selections) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_filters"></a> [msteams\_filters](#input\_msteams\_filters) | Filters for the Microsoft Teams Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_msteams_metric_exceptions"></a> [msteams\_metric\_exceptions](#input\_msteams\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_metric_selections"></a> [msteams\_metric\_selections](#input\_msteams\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_msteams_name"></a> [msteams\_name](#input\_msteams\_name) | Name of the Microsoft Teams Subscription Equinix Resource | `string` | `""` | no |
| <a name="input_msteams_uri"></a> [msteams\_uri](#input\_msteams\_uri) | Microsoft Teams URI for destination of streaming messages | `string` | `""` | no |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_pagerduty_alert_uri"></a> [pagerduty\_alert\_uri](#input\_pagerduty\_alert\_uri) | PagerDuty App URI for receiving streamed alerts | `string` | `""` | no |
| <a name="input_pagerduty_change_uri"></a> [pagerduty\_change\_uri](#input\_pagerduty\_change\_uri) | PagerDuty App URI for receiving streamed changes | `string` | `""` | no |
| <a name="input_pagerduty_description"></a> [pagerduty\_description](#input\_pagerduty\_description) | Description of the PagerDuty Subscription | `string` | `""` | no |
| <a name="input_pagerduty_enabled"></a> [pagerduty\_enabled](#input\_pagerduty\_enabled) | Boolean value enabling PagerDuty Subscription | `string` | `""` | no |
| <a name="input_pagerduty_event_exceptions"></a> [pagerduty\_event\_exceptions](#input\_pagerduty\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_event_selections"></a> [pagerduty\_event\_selections](#input\_pagerduty\_event\_selections) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_filters"></a> [pagerduty\_filters](#input\_pagerduty\_filters) | Filters for the PagerDuty Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_pagerduty_host"></a> [pagerduty\_host](#input\_pagerduty\_host) | PagerDuty Sink Hostname | `string` | `""` | no |
| <a name="input_pagerduty_integration_key"></a> [pagerduty\_integration\_key](#input\_pagerduty\_integration\_key) | Application Key for PagerDuty App receiving the streaming messages | `string` | `""` | no |
| <a name="input_pagerduty_metric_exceptions"></a> [pagerduty\_metric\_exceptions](#input\_pagerduty\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_metric_selections"></a> [pagerduty\_metric\_selections](#input\_pagerduty\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_pagerduty_name"></a> [pagerduty\_name](#input\_pagerduty\_name) | Name of the PagerDuty Subscription Equinix Resource | `string` | `""` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_slack_description"></a> [slack\_description](#input\_slack\_description) | Description of the slack Subscription | `string` | `""` | no |
| <a name="input_slack_enabled"></a> [slack\_enabled](#input\_slack\_enabled) | Boolean value enabling slack Subscription | `string` | `""` | no |
| <a name="input_slack_event_exceptions"></a> [slack\_event\_exceptions](#input\_slack\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_event_selections"></a> [slack\_event\_selections](#input\_slack\_event\_selections) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_filters"></a> [slack\_filters](#input\_slack\_filters) | Filters for the slack Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_slack_metric_exceptions"></a> [slack\_metric\_exceptions](#input\_slack\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_metric_selections"></a> [slack\_metric\_selections](#input\_slack\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_name"></a> [slack\_name](#input\_slack\_name) | Name of the slack Subscription Equinix Resource | `string` | `""` | no |
| <a name="input_slack_uri"></a> [slack\_uri](#input\_slack\_uri) | API Key for slack account | `string` | `""` | no |
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
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Port Name | `string` | n/a | yes |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_subscription"></a> [datadog\_subscription](#output\_datadog\_subscription) | n/a |
| <a name="output_first_stream"></a> [first\_stream](#output\_first\_stream) | n/a |
| <a name="output_msteams_subscription"></a> [msteams\_subscription](#output\_msteams\_subscription) | n/a |
| <a name="output_pagerduty_subscription"></a> [pagerduty\_subscription](#output\_pagerduty\_subscription) | n/a |
| <a name="output_port_attachment_on_first_stream"></a> [port\_attachment\_on\_first\_stream](#output\_port\_attachment\_on\_first\_stream) | n/a |
| <a name="output_port_attachment_on_second_stream"></a> [port\_attachment\_on\_second\_stream](#output\_port\_attachment\_on\_second\_stream) | n/a |
| <a name="output_port_connection"></a> [port\_connection](#output\_port\_connection) | n/a |
| <a name="output_second_stream"></a> [second\_stream](#output\_second\_stream) | n/a |
| <a name="output_slack_subscription"></a> [slack\_subscription](#output\_slack\_subscription) | n/a |
| <a name="output_splunk_subscription"></a> [splunk\_subscription](#output\_splunk\_subscription) | n/a |
<!-- END_TF_DOCS -->
