# Fabric Stream and Stream Subscription - Splunk Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Splunk Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-splunk-subscription
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
```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_splunk_subscription.first_stream
  sensitive = true
}

output "splunk_subscription" {
  value     = module.stream_splunk_subscription.splunk_subscription
  sensitive = true
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
  splunk_filters           = var.splunk_filters
  splunk_event_exceptions  = var.splunk_event_exceptions
  splunk_event_selections  = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source            = var.splunk_source
  splunk_event_index       = var.splunk_event_index
  splunk_metric_index      = var.splunk_metric_index
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_stream_splunk_subscription"></a> [stream\_splunk\_subscription](#module\_stream\_splunk\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
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

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_splunk_subscription"></a> [splunk\_subscription](#output\_splunk\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
