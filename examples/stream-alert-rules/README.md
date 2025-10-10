# Fabric Stream Alert Rules

This example shows how to leverage the [Fabric Stream Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and Splunk Fabric Stream Subscription. 
It also shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection) 
to create a port to port connection. It creates a Fabric Stream Attachment on top of the created connection.

It leverages the Equinix Terraform Provider, Fabric Stream Module, Fabric Port Connection Module, equinix_fabric_stream_attachment resource 
and equinix_fabric_stream_alert_rule resource to setup the stream alert rule based on the parameters you have provided to this example.

Additionally, the patterns found in this example can be followed in your own custom Terraform configurations for more complex solutions.

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
cd terraform-equinix-fabric/examples/stream-alert-rules
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

stream_name        = "EmergingNetworksStream"
stream_description = "Source for Equinix Events/Metrics/Alerts"

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

asset                 = "<asset_type>"

type                  = "METRIC_ALERT"
name                  = "stream-alert-rule"
description           = "stream-alert-rule-description"
operand               = "ABOVE"
window_size           = "PT15M"
warning_threshold     = "<warning_threshold>"
critical_threshold    = "<critical_threshold>"
metric_name           = "equinix.fabric.connection.bandwidth_tx.usage"
resource_selector     = {
    "include" = ["*/connections/<connection_id>"]
}
pagination = {
    limit = 20
    offset = 0
}
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 3.10.0"
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
variable "stream_name" {
  description = "Stream name"
  type        = string
}
variable "stream_description" {
  description = "Stream description"
  type        = string
}
variable "splunk_enabled" {
  description = "Boolean value indicating enablement of the Splunk Subscription"
  type        = bool
  default     = true
}
variable "splunk_access_token" {
  description = "Credential for Splunk Sink Subscription"
  type        = string
  default     = ""
  sensitive   = true
}
variable "splunk_name" {
  description = "Name of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "splunk_description" {
  description = "Description of the Splunk Equinix Subscription Resource"
  type        = string
  default     = ""
}

variable "splunk_uri" {
  description = "URI for the streaming messages to be sent to for Splunk"
  type        = string
  default     = ""
}
variable "splunk_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_metric_exceptions" {
  description = "Metrics to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_metric_selections" {
  description = "Metrics to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "splunk_source" {
  description = "Name of the created Splunk Source for the destination of the streaming messages"
  type        = string
  default     = ""
}
variable "splunk_event_index" {
  description = "Event index for the Splunk Sink Source"
  type        = string
  default     = ""
}
variable "splunk_metric_index" {
  description = "Metric index for Splunk Sink Source"
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
  description = "Vlan tag for DOT1Q or QINQ connections"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_port_name" {
  description = "Equinix Port Name"
  type        = string
}
variable "zside_vlan_tag" {
  description = "Vlan tag for DOT1Q or QINQ connections"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "asset_type" {
  description = "Asset type"
  type        = string
}
variable "alert_rule_name" {
  description = "Alert rule name"
  type        = string
}
variable "alert_rule_description" {
  description = "Alert rule description"
  type        = string
}
variable "operand" {
  description = "Operand for the alert rule"
  type        = string
}
variable "window_size" {
  description = "Alert rule window size"
  type        = string
}
variable "warning_threshold" {
  description = "Warning threshold for the alert rule"
  type        = string
}
variable "critical_threshold" {
  description = "Critical threshold for the alert rule"
  type        = string
}
variable "metric_name" {
  description = "Metric Name for the alert rule"
  type        = string
}
variable "limit" {
  description = "Limit for pagination of alert rules"
  type        = number
}
variable "offset" {
  description = "Offset for pagination of alert rules"
  type        = number
}
```

outputs.tf
```hcl
output "stream_id" {
  value = module.stream_splunk_subscription.first_stream.id
}
output "connection_id" {
  value = module.create_port_2_port_connection.primary_connection_id
}
output "stream_alert_rule_id" {
  value = equinix_fabric_stream_alert_rule.alert_rule.uuid
}
output "stream_alert_rule_state" {
  value = equinix_fabric_stream_alert_rule.alert_rule.state
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_splunk_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  splunk_enabled           = var.splunk_enabled
  splunk_access_token      = var.splunk_access_token
  splunk_name              = var.splunk_name
  splunk_description       = var.splunk_description
  splunk_uri               = var.splunk_uri
  splunk_event_exceptions  = var.splunk_event_exceptions
  splunk_event_selections  = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source            = var.splunk_source
  splunk_event_index       = var.splunk_event_index
  splunk_metric_index      = var.splunk_metric_index
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

resource "equinix_fabric_stream_attachment" "attachment" {
  depends_on = [
    module.stream_splunk_subscription,
    module.create_port_2_port_connection
  ]

  asset_id  = module.create_port_2_port_connection.primary_connection_id
  asset     = var.asset_type
  stream_id =  module.stream_splunk_subscription.first_stream.id
}

resource "equinix_fabric_stream_alert_rule" "alert_rule" {
  depends_on = [
    equinix_fabric_stream_attachment.attachment
  ]
  type               = "METRIC_ALERT"
  stream_id          =  module.stream_splunk_subscription.first_stream.id
  name               = var.alert_rule_name
  description        = var.alert_rule_description
  operand            = var.operand
  window_size        = var.window_size
  warning_threshold  = var.warning_threshold
  critical_threshold = var.critical_threshold
  metric_name        = var.metric_name
  resource_selector  = {
    "include" = [
      "*/${equinix_fabric_stream_attachment.attachment.asset}/${module.create_port_2_port_connection.primary_connection_id}"
    ]
  }
}

data "equinix_fabric_stream_alert_rule" "alert_rule" {
  depends_on = [
    module.stream_splunk_subscription,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id =  module.stream_splunk_subscription.first_stream.id
  alert_rule_id = equinix_fabric_stream_alert_rule.alert_rule.id
}

data "equinix_fabric_stream_alert_rules" "alert_rules" {
  depends_on = [
    module.stream_splunk_subscription,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id =  module.stream_splunk_subscription.first_stream.id
  pagination = {
    limit = var.limit
    offset = var.offset
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 3.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_port_connection"></a> [create\_port\_2\_port\_connection](#module\_create\_port\_2\_port\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |
| <a name="module_stream_splunk_subscription"></a> [stream\_splunk\_subscription](#module\_stream\_splunk\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_stream_alert_rule.alert_rule](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_alert_rule) | resource |
| [equinix_fabric_stream_attachment.attachment](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_stream_attachment) | resource |
| [equinix_fabric_stream_alert_rule.alert_rule](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_stream_alert_rule) | data source |
| [equinix_fabric_stream_alert_rules.alert_rules](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_stream_alert_rules) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_rule_description"></a> [alert\_rule\_description](#input\_alert\_rule\_description) | Alert rule description | `string` | n/a | yes |
| <a name="input_alert_rule_name"></a> [alert\_rule\_name](#input\_alert\_rule\_name) | Alert rule name | `string` | n/a | yes |
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan tag for DOT1Q or QINQ connections | `string` | n/a | yes |
| <a name="input_asset_type"></a> [asset\_type](#input\_asset\_type) | Asset type | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_critical_threshold"></a> [critical\_threshold](#input\_critical\_threshold) | Critical threshold for the alert rule | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_limit"></a> [limit](#input\_limit) | Limit for pagination of alert rules | `number` | n/a | yes |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | Metric Name for the alert rule | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_offset"></a> [offset](#input\_offset) | Offset for pagination of alert rules | `number` | n/a | yes |
| <a name="input_operand"></a> [operand](#input\_operand) | Operand for the alert rule | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_splunk_access_token"></a> [splunk\_access\_token](#input\_splunk\_access\_token) | Credential for Splunk Sink Subscription | `string` | `""` | no |
| <a name="input_splunk_description"></a> [splunk\_description](#input\_splunk\_description) | Description of the Splunk Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_splunk_enabled"></a> [splunk\_enabled](#input\_splunk\_enabled) | Boolean value indicating enablement of the Splunk Subscription | `bool` | `true` | no |
| <a name="input_splunk_event_exceptions"></a> [splunk\_event\_exceptions](#input\_splunk\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_event_index"></a> [splunk\_event\_index](#input\_splunk\_event\_index) | Event index for the Splunk Sink Source | `string` | `""` | no |
| <a name="input_splunk_event_selections"></a> [splunk\_event\_selections](#input\_splunk\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_metric_exceptions"></a> [splunk\_metric\_exceptions](#input\_splunk\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_metric_index"></a> [splunk\_metric\_index](#input\_splunk\_metric\_index) | Metric index for Splunk Sink Source | `string` | `""` | no |
| <a name="input_splunk_metric_selections"></a> [splunk\_metric\_selections](#input\_splunk\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_splunk_name"></a> [splunk\_name](#input\_splunk\_name) | Name of the Splunk Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_splunk_source"></a> [splunk\_source](#input\_splunk\_source) | Name of the created Splunk Source for the destination of the streaming messages | `string` | `""` | no |
| <a name="input_splunk_uri"></a> [splunk\_uri](#input\_splunk\_uri) | URI for the streaming messages to be sent to for Splunk | `string` | `""` | no |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Stream description | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Stream name | `string` | n/a | yes |
| <a name="input_warning_threshold"></a> [warning\_threshold](#input\_warning\_threshold) | Warning threshold for the alert rule | `string` | n/a | yes |
| <a name="input_window_size"></a> [window\_size](#input\_window\_size) | Alert rule window size | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Port Name | `string` | n/a | yes |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | Vlan tag for DOT1Q or QINQ connections | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_id"></a> [connection\_id](#output\_connection\_id) | n/a |
| <a name="output_stream_alert_rule_id"></a> [stream\_alert\_rule\_id](#output\_stream\_alert\_rule\_id) | n/a |
| <a name="output_stream_alert_rule_state"></a> [stream\_alert\_rule\_state](#output\_stream\_alert\_rule\_state) | n/a |
| <a name="output_stream_id"></a> [stream\_id](#output\_stream\_id) | n/a |
<!-- END_TF_DOCS -->