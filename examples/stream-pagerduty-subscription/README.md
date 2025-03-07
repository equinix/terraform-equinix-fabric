# Fabric Stream and Stream Subscription - PagerDuty Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a PagerDuty Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-pagerduty-subscription
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

```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 3.3.0"
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
```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_pagerduty_subscription.first_stream
  sensitive = true
}

output "pagerduty_subscription" {
  value     = module.stream_pagerduty_subscription.pagerduty_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_pagerduty_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

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
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_stream_pagerduty_subscription"></a> [stream\_pagerduty\_subscription](#module\_stream\_pagerduty\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
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
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pagerduty_subscription"></a> [pagerduty\_subscription](#output\_pagerduty\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
