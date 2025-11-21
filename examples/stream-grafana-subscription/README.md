# Fabric Stream and Stream Subscription - Grafana Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Grafana Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-grafana-subscription
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

grafana_name              = "grafanaSub"
grafana_description       = "Destination for Equinix Events/Metrics/Alerts"
grafana_enabled           = true
grafana_filters = [{
  property = "/type"
  operator = "LIKE"
  values = [
    "equinix.fabric.connection%"
  ]
}]
grafana_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
grafana_event_selections  = ["equinix.fabric.router.*"]
grafana_metric_exceptions = ["equinix.fabric.connection.*"]
grafana_metric_selections = ["equinix.fabric.port.*"]
grafana_event_uri         = "<grafana_event_uri>"
grafana_metric_uri        = "<grafana_metric_uri>"
grafana_format            = "<grafana_format>"
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
variable "grafana_event_uri" {
  description = "URI for the streaming messages to be sent to for grafana"
  type        = string
}
variable "grafana_metric_uri" {
  description = "URI for the streaming messages to be sent to for grafana"
  type        = string
}
variable "grafana_name" {
  description = "Name of the grafana Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "grafana_description" {
  description = "Description for the grafana Subscription Resource"
  type        = string
  default     = ""
}
variable "grafana_enabled" {
  description = "Boolean value enabling grafana Sink Subscription"
  type        = string
  default     = ""
}
variable "grafana_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_host" {
  description = "grafana Host for the streaming messages destination"
  type        = string
  default     = ""
}
variable "grafana_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_metric_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_metric_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "grafana_format" {
  description = "Format for grafana payload"
  type        = string
  default     = null
}
variable "grafana_filters" {
  description = "Filters for the Grafana Subscription"
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
  value     = module.stream_grafana_subscription.first_stream
  sensitive = true
}

output "grafana_subscription" {
  value     = module.stream_grafana_subscription.grafana_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_grafana_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name               = var.stream_name
  stream_description        = var.stream_description

  grafana_name              = var.grafana_name
  grafana_description       = var.grafana_description
  grafana_enabled           = var.grafana_enabled
  grafana_event_exceptions  = var.grafana_event_exceptions
  grafana_event_selections  = var.grafana_event_selections
  grafana_metric_exceptions = var.grafana_metric_exceptions
  grafana_metric_selections = var.grafana_metric_selections
  grafana_event_uri         = var.grafana_event_uri
  grafana_metric_uri        = var.grafana_metric_uri
  grafana_format            = var.grafana_format
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
| <a name="module_stream_grafana_subscription"></a> [stream\_grafana\_subscription](#module\_stream\_grafana\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_grafana_description"></a> [grafana\_description](#input\_grafana\_description) | Description for the grafana Subscription Resource | `string` | `""` | no |
| <a name="input_grafana_enabled"></a> [grafana\_enabled](#input\_grafana\_enabled) | Boolean value enabling grafana Sink Subscription | `string` | `""` | no |
| <a name="input_grafana_event_exceptions"></a> [grafana\_event\_exceptions](#input\_grafana\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_grafana_event_selections"></a> [grafana\_event\_selections](#input\_grafana\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_grafana_event_uri"></a> [grafana\_event\_uri](#input\_grafana\_event\_uri) | URI for the streaming messages to be sent to for grafana | `string` | n/a | yes |
| <a name="input_grafana_filters"></a> [grafana\_filters](#input\_grafana\_filters) | Filters for the Grafana Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_grafana_format"></a> [grafana\_format](#input\_grafana\_format) | Format for grafana payload | `string` | `null` | no |
| <a name="input_grafana_host"></a> [grafana\_host](#input\_grafana\_host) | grafana Host for the streaming messages destination | `string` | `""` | no |
| <a name="input_grafana_metric_exceptions"></a> [grafana\_metric\_exceptions](#input\_grafana\_metric\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_grafana_metric_selections"></a> [grafana\_metric\_selections](#input\_grafana\_metric\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_grafana_metric_uri"></a> [grafana\_metric\_uri](#input\_grafana\_metric\_uri) | URI for the streaming messages to be sent to for grafana | `string` | n/a | yes |
| <a name="input_grafana_name"></a> [grafana\_name](#input\_grafana\_name) | Name of the grafana Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_subscription"></a> [grafana\_subscription](#output\_grafana\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
