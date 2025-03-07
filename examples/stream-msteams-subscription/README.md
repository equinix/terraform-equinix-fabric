# Fabric Stream and Stream Subscription - Microsoft Teams Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Microsoft Teams Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-msteams-subscription
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
```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_msteams_subscription.first_stream
  sensitive = true
}

output "msteams_subscription" {
  value     = module.stream_msteams_subscription.msteams_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_msteams_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  msteams_name              = var.msteams_name
  msteams_description       = var.msteams_description
  msteams_enabled           = var.msteams_enabled
  msteams_uri               = var.msteams_uri
  msteams_filters           = var.msteams_filters
  msteams_event_exceptions  = var.msteams_event_exceptions
  msteams_event_selections  = var.msteams_event_selections
  msteams_metric_exceptions = var.msteams_metric_exceptions
  msteams_metric_selections = var.msteams_metric_selections
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
| <a name="module_stream_msteams_subscription"></a> [stream\_msteams\_subscription](#module\_stream\_msteams\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_msteams_subscription"></a> [msteams\_subscription](#output\_msteams\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
