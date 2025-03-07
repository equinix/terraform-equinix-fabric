# Fabric Stream and Stream Subscription - Slack Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Slack Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-slack-subscription
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
```

outputs.tf
```hcl
output "stream" {
  value     = module.stream_slack_subscription.first_stream
  sensitive = true
}

output "slack_subscription" {
  value     = module.stream_slack_subscription.slack_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_slack_subscription" {
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
| <a name="module_stream_slack_subscription"></a> [stream\_slack\_subscription](#module\_stream\_slack\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_slack_description"></a> [slack\_description](#input\_slack\_description) | Description of the slack Subscription | `string` | `""` | no |
| <a name="input_slack_enabled"></a> [slack\_enabled](#input\_slack\_enabled) | Boolean value enabling slack Subscription | `string` | `""` | no |
| <a name="input_slack_event_exceptions"></a> [slack\_event\_exceptions](#input\_slack\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_event_selections"></a> [slack\_event\_selections](#input\_slack\_event\_selections) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_filters"></a> [slack\_filters](#input\_slack\_filters) | Filters for the slack Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_slack_metric_exceptions"></a> [slack\_metric\_exceptions](#input\_slack\_metric\_exceptions) | Metrics to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_metric_selections"></a> [slack\_metric\_selections](#input\_slack\_metric\_selections) | Metrics to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_slack_name"></a> [slack\_name](#input\_slack\_name) | Name of the slack Subscription Equinix Resource | `string` | `""` | no |
| <a name="input_slack_uri"></a> [slack\_uri](#input\_slack\_uri) | API Key for slack account | `string` | `""` | no |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_slack_subscription"></a> [slack\_subscription](#output\_slack\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
