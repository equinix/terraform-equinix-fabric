# Fabric Stream and Stream Subscription - Webhook Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Webhook Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-webhook-subscription
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

webhook_name              = "webhookSub"
webhook_description       = "Destination for Equinix Events/Metrics/Alerts"
webhook_enabled           = true
webhook_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
webhook_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
webhook_event_selections  = ["equinix.fabric.router.*"]
webhook_metric_exceptions = ["equinix.fabric.connection.*"]
webhook_metric_selections = ["equinix.fabric.port.*"]
webhook_event_uri         = "<webhook_event_uri>"
webhook_metric_uri        = "<webhook_metric_uri>"
webhook_format            = "<webhook_format>"
```

versions.tf
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
  default     = null
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

```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_webhook_subscription.first_stream
  sensitive = true
}

output "webhook_subscription" {
  value     = module.stream_webhook_subscription.webhook_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_webhook_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name               = var.stream_name
  stream_description        = var.stream_description

  webhook_name              = var.webhook_name
  webhook_description       = var.webhook_description
  webhook_enabled           = var.webhook_enabled
  webhook_event_exceptions  = var.webhook_event_exceptions
  webhook_event_selections  = var.webhook_event_selections
  webhook_metric_exceptions = var.webhook_metric_exceptions
  webhook_metric_selections = var.webhook_metric_selections
  webhook_event_uri         = var.webhook_event_uri
  webhook_metric_uri         = var.webhook_metric_uri
  webhook_format            = var.webhook_format
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 4.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_stream_webhook_subscription"></a> [stream\_webhook\_subscription](#module\_stream\_webhook\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_webhook_description"></a> [webhook\_description](#input\_webhook\_description) | Description for the webhook Subscription Resource | `string` | `""` | no |
| <a name="input_webhook_enabled"></a> [webhook\_enabled](#input\_webhook\_enabled) | Boolean value enabling webhook Sink Subscription | `string` | `""` | no |
| <a name="input_webhook_event_exceptions"></a> [webhook\_event\_exceptions](#input\_webhook\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_webhook_event_selections"></a> [webhook\_event\_selections](#input\_webhook\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_webhook_event_uri"></a> [webhook\_event\_uri](#input\_webhook\_event\_uri) | URI for the streaming messages to be sent to for webhook | `string` | n/a | yes |
| <a name="input_webhook_filters"></a> [webhook\_filters](#input\_webhook\_filters) | Filters for the Servicenow Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_webhook_format"></a> [webhook\_format](#input\_webhook\_format) | Format of the webhook messages | `string` | `null` | no |
| <a name="input_webhook_host"></a> [webhook\_host](#input\_webhook\_host) | Webhook Host for the streaming messages destination | `string` | `""` | no |
| <a name="input_webhook_metric_exceptions"></a> [webhook\_metric\_exceptions](#input\_webhook\_metric\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_webhook_metric_selections"></a> [webhook\_metric\_selections](#input\_webhook\_metric\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_webhook_metric_uri"></a> [webhook\_metric\_uri](#input\_webhook\_metric\_uri) | URI for the streaming messages to be sent to for webhook | `string` | n/a | yes |
| <a name="input_webhook_name"></a> [webhook\_name](#input\_webhook\_name) | Name of the webhook Equinix Subscription Resource | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
| <a name="output_webhook_subscription"></a> [webhook\_subscription](#output\_webhook\_subscription) | n/a |
<!-- END_TF_DOCS -->
