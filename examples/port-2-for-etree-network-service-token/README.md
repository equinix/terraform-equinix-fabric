# Fabric Service Token for Zside Network Creation Example

This example shows how to create Fabric Zside Network based Service Token.

It leverages the Equinix Terraform Provider to setup the service token based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

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
cd terraform-equinix-fabric/examples/service-token-for-zside-network
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

#Service Token
service_token_type                  = "VC_TOKEN"
service_token_name                  = "Terra_Test_Token"
service_token_description           = "Zside VD Token Test"
service_token_expiration_date_time  = "2024-12-29T06:43:49.980Z"
notifications_type                  = "ALL"
notifications_emails                = ["example@equinix.com"]
connection_type                     = "EVPL_VC"
supported_bandwidths                = [50,100, 500, 1000]
zside_ap_type                       = "NETWORK"
zside_network_uuid                  = "<Network_UUID>"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source="equinix/equinix"
      version = ">= 3.1.0"
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

#Service Token
variable "service_token_name" {
  description = "Service Token Name"
  type        = string
}
variable "service_token_type" {
  description = "Service Token Type; VC_TOKEN,EPL_TOKEN"
  type        = string
}
variable "service_token_description" {
  description = "Service Token Description"
  type        = string
}
variable "service_token_expiration_date_time" {
  description = "Expiration date and time of the service token; 2020-11-06T07:00:00"
  type        = string
}
variable "notifications_type" {
  description = "Notification Type - ALL is the only type currently supported"
  type        = string
}
variable "notifications_emails" {
  description = "Array of contact emails"
  type        = list(string)
}
variable "connection_type" {
  description = "Type of Connection supported by Service Token you will create; EVPL_VC, EVPLAN_VC, EPLAN_VC, IPWAN_VC"
  type        = string
}
variable "supported_bandwidths" {
  description = "List of permitted bandwidths"
  type        = list
}
variable "zside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "zside_network_type" {
  description = "Network type"
  type        = string
}
variable "zside_network_uuid" {
  description = "Network UUID"
  type        = string
}
```

outputs.tf
```hcl
output "service_token_id" {
  value = equinix_fabric_service_token.service-token.id
}
output "service-token" {
  value = equinix_fabric_service_token.service-token
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_service_token" "service-token" {
  type                 = var.service_token_type
  name                 = var.service_token_name
  description          = var.service_token_description
  expiration_date_time = var.service_token_expiration_date_time
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  service_token_connection {
    type                 = var.connection_type
    supported_bandwidths = var.supported_bandwidths
    z_side {
      access_point_selectors {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_service_token.service-token](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_service_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Type of Connection supported by Service Token you will create; EVPL\_VC, EVPLAN\_VC, EPLAN\_VC, IPWAN\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | n/a | yes |
| <a name="input_service_token_description"></a> [service\_token\_description](#input\_service\_token\_description) | Service Token Description | `string` | n/a | yes |
| <a name="input_service_token_expiration_date_time"></a> [service\_token\_expiration\_date\_time](#input\_service\_token\_expiration\_date\_time) | Expiration date and time of the service token; 2020-11-06T07:00:00 | `string` | n/a | yes |
| <a name="input_service_token_name"></a> [service\_token\_name](#input\_service\_token\_name) | Service Token Name | `string` | n/a | yes |
| <a name="input_service_token_type"></a> [service\_token\_type](#input\_service\_token\_type) | Service Token Type; VC\_TOKEN,EPL\_TOKEN | `string` | n/a | yes |
| <a name="input_supported_bandwidths"></a> [supported\_bandwidths](#input\_supported\_bandwidths) | List of permitted bandwidths | `list` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Type of Access point; COLO, VD, NETWORK | `string` | n/a | yes |
| <a name="input_zside_network_type"></a> [zside\_network\_type](#input\_zside\_network\_type) | Network type | `string` | n/a | yes |
| <a name="input_zside_network_uuid"></a> [zside\_network\_uuid](#input\_zside\_network\_uuid) | Network UUID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service-token"></a> [service-token](#output\_service-token) | n/a |
| <a name="output_service_token_id"></a> [service\_token\_id](#output\_service\_token\_id) | n/a |
<!-- END_TF_DOCS -->
