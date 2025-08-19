# Fabric Stream and Stream Subscription - Servicenow Subscription

This example shows how to leverage the [Fabric Stream Module
](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/streaming-observability)
to create a Fabric Stream and a Servicenow Fabric Stream Subscription.

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
cd terraform-equinix-fabric/examples/stream-servicenow-subscription
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

servicenow_name              = "ServicenowSub"
servicenow_description       = "Destination for Equinix Events/Metrics/Alerts"
servicenow_enabled           = true
servicenow_host              = "<customer_specific_host>"
servicenow_event_exceptions  = ["equinix.fabric.connection.route_filter.pending_bgp_configuration"]
servicenow_event_selections  = ["equinix.fabric.router.*"]
servicenow_metric_exceptions = ["equinix.fabric.connection.*"]
servicenow_metric_selections = ["equinix.fabric.port.*"]
servicenow_username          = "<username>"
servicenow_password          = "<password>"
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
variable "servicenow_uri" {
  description = "URI for the streaming messages to be sent to for ServiceNow"
  type        = string
  default     = ""
}
variable "servicenow_name" {
  description = "Name of the ServiceNow Equinix Subscription Resource"
  type        = string
  default     = ""
}
variable "servicenow_description" {
  description = "Description for the ServiceNow Subscription Resource"
  type        = string
  default     = ""
}
variable "servicenow_enabled" {
  description = "Boolean value enabling ServiceNow Sink Subscription"
  type        = string
  default     = ""
}
variable "servicenow_event_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_event_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_exceptions" {
  description = "Events to exclude from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_metric_selections" {
  description = "Events to include from the possibilities available to the stream for the Subscription"
  type        = list(string)
  default     = []
}
variable "servicenow_host" {
  description = "ServiceNow Host for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_username" {
  description = "ServiceNow Username for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_password" {
  description = "ServiceNow Password for the streaming messages destination"
  type        = string
  default     = ""
}
variable "servicenow_filters" {
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
  value     = module.stream_servicenow_subscription.first_stream
  sensitive = true
}

output "servicenow_subscription" {
  value     = module.stream_servicenow_subscription.servicenow_subscription
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_servicenow_subscription" {
  source = "equinix/fabric/equinix//modules/streaming-observability"

  stream_name                  = var.stream_name
  stream_description           = var.stream_description

  servicenow_name              = var.servicenow_name
  servicenow_description       = var.servicenow_description
  servicenow_enabled           = var.servicenow_enabled
  servicenow_host              = var.servicenow_host
  servicenow_event_exceptions  = var.servicenow_event_exceptions
  servicenow_event_selections  = var.servicenow_event_selections
  servicenow_metric_exceptions = var.servicenow_metric_exceptions
  servicenow_metric_selections = var.servicenow_metric_selections
  servicenow_username          = var.servicenow_username
  servicenow_password          = var.servicenow_password
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
| <a name="module_stream_servicenow_subscription"></a> [stream\_servicenow\_subscription](#module\_stream\_servicenow\_subscription) | equinix/fabric/equinix//modules/streaming-observability | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_servicenow_description"></a> [servicenow\_description](#input\_servicenow\_description) | Description for the ServiceNow Subscription Resource | `string` | `""` | no |
| <a name="input_servicenow_enabled"></a> [servicenow\_enabled](#input\_servicenow\_enabled) | Boolean value enabling ServiceNow Sink Subscription | `string` | `""` | no |
| <a name="input_servicenow_event_exceptions"></a> [servicenow\_event\_exceptions](#input\_servicenow\_event\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_event_selections"></a> [servicenow\_event\_selections](#input\_servicenow\_event\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_filters"></a> [servicenow\_filters](#input\_servicenow\_filters) | Filters for the Servicenow Subscription | <pre>list(object({<br>    property = string,<br>    operator = string,<br>    values   = list(string),<br>    or       = optional(bool),<br>  }))</pre> | `[]` | no |
| <a name="input_servicenow_host"></a> [servicenow\_host](#input\_servicenow\_host) | ServiceNow Host for the streaming messages destination | `string` | `""` | no |
| <a name="input_servicenow_metric_exceptions"></a> [servicenow\_metric\_exceptions](#input\_servicenow\_metric\_exceptions) | Events to exclude from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_metric_selections"></a> [servicenow\_metric\_selections](#input\_servicenow\_metric\_selections) | Events to include from the possibilities available to the stream for the Subscription | `list(string)` | `[]` | no |
| <a name="input_servicenow_name"></a> [servicenow\_name](#input\_servicenow\_name) | Name of the ServiceNow Equinix Subscription Resource | `string` | `""` | no |
| <a name="input_servicenow_password"></a> [servicenow\_password](#input\_servicenow\_password) | ServiceNow Password for the streaming messages destination | `string` | `""` | no |
| <a name="input_servicenow_uri"></a> [servicenow\_uri](#input\_servicenow\_uri) | URI for the streaming messages to be sent to for ServiceNow | `string` | `""` | no |
| <a name="input_servicenow_username"></a> [servicenow\_username](#input\_servicenow\_username) | ServiceNow Username for the streaming messages destination | `string` | `""` | no |
| <a name="input_stream_description"></a> [stream\_description](#input\_stream\_description) | Description of the created stream(s) in the module | `string` | n/a | yes |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name (and name prefix) for the created stream(s) in the module | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_servicenow_subscription"></a> [servicenow\_subscription](#output\_servicenow\_subscription) | n/a |
| <a name="output_stream"></a> [stream](#output\_stream) | n/a |
<!-- END_TF_DOCS -->
