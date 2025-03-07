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
cd terraform-equinix-fabric/examples/stream-datadog-subscription
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
```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_datadog_subscription.first_stream
  sensitive = true
}

output "datadog_subscription" {
  value     = module.stream_datadog_subscription.datadog_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_datadog_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

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
| <a name="module_stream_datadog_subscription"></a> [stream\_datadog\_subscription](#module\_stream\_datadog\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

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
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_subscription"></a> [datadog\_subscription](#output\_datadog\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
