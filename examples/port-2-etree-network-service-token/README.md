# Fabric Service Token for Zside Network Creation Example

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection) 
to create a Fabric Connection from a Fabric Port to Fabric Zside Etree Network based Service Token.

It leverages the Equinix Terraform Provider, equinix_fabric_network Terraform resource, equinix_fabric_service_token Terraform resource and Fabric Port Connection
Module to setup the service token based on the parameters you have provided to this example; or based on the pattern
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
cd terraform-equinix-fabric/examples/port-2-etree-network-service-token
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

#Etree Network
network_name          = "EVPTreeNetwork"
network_type          = "EVPTREE"
scope                 = "LOCAL"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com", "test1@equinix.com"]
project_id            = "345250818654"

#Service Token
service_token_type                  = "VC_TOKEN"
service_token_name                  = "Terra_Test_Token"
service_token_description           = "Zside Etree Network Service Token"
service_token_expiration_date_time  = "2025-10-29T06:43:49.980Z"
notifications_type                  = "ALL"
notifications_emails                = ["example@equinix.com"]
project_id                          = "345250818654"
connection_type                     = "EVPTREE_VC"
allow_remote_connection             = true
supported_bandwidths                = [50,100, 500, 1000]
zside_ap_type                       = "NETWORK"
zside_network_uuid                  = "<Network_UUID>"

#Connection
connection_name          = "Port2Port"
connection_type          = "EVPL_VC"
notifications_type       = "ALL"
notifications_emails     = ["example@equinix.com", "test1@equinix.com"]
bandwidth                = 50
purchase_order_number    = "1-323292"
term_length              = 12
aside_port_name          = "ops-user100-CX-SV5-NL-Qinq-STD-1G-SEC-JP-190"
aside_vlan_tag           = "1976"
zside_service_token_uuid = "Service_Token_UUID"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = ">= 4.2.0"
    }
  }
}
```

variables.tf
 ```hcl

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
variable "supported_bandwidths" {
  description = "List of permitted bandwidths"
  type        = list
  default     = []
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
variable "role" {
  description = "Role of network"
  type        = string
}
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
variable "term_length" {
  description = "Order Term Length"
  type        = number
  default     = 1
}
variable "aside_port_name" {
  description = "Equinix A-Side Port Name"
  type        = string
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
variable "aside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
}
variable "network_type" {
  description = "Equinix A-Side Network Type"
  type        = string
}
variable "network_name" {
  description = "Equinix Network Name"
  type        = string
}
variable "network_scope" {
  description = "Equinix Network Scope"
  type        = string
}
```

outputs.tf
```hcl
output "etree_network" {
  value = equinix_fabric_network.etree_network
}
output "etree_network_id" {
  value = equinix_fabric_network.etree_network.id
}
output "service_token_id" {
  value = equinix_fabric_service_token.service-token.id
}
output "service-token" {
  value = equinix_fabric_service_token.service-token
}
output "port_connection" {
  value = module.port_2_network_service_token_connection_id.primary_connection
  sensitive = true
}
output "port_2_network_service_token_connection_id" {
  value = module.port_2_network_service_token_connection_id.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_network" "etree_network" {
  name  = var.network_name
  type  = var.network_type
  scope = var.network_scope
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
}

resource "equinix_fabric_service_token" "service-token" {
  type                 = "VC_TOKEN"
  name                 = var.service_token_name
  description          = var.service_token_description
  expiration_date_time = var.service_token_expiration_date_time
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
  service_token_connection {
    type                    = var.connection_type
    allow_remote_connection = true
    supported_bandwidths    = var.supported_bandwidths
    z_side {
      access_point_selectors {
        type = "NETWORK"
        network {
          uuid = equinix_fabric_network.etree_network.id
        }
      }
    }
  }
}

module "port_2_network_service_token_connection_id" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  term_length           = var.term_length

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_service_token_uuid = equinix_fabric_service_token.service-token.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 4.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 4.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_port_2_network_service_token_connection_id"></a> [port\_2\_network\_service\_token\_connection\_id](#module\_port\_2\_network\_service\_token\_connection\_id) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_network.etree_network](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_network) | resource |
| [equinix_fabric_service_token.service-token](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_service_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values. | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | Type of Access point; COLO, VD, NETWORK | `string` | n/a | yes |
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Equinix Network Name | `string` | n/a | yes |
| <a name="input_network_scope"></a> [network\_scope](#input\_network\_scope) | Equinix Network Scope | `string` | n/a | yes |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | Equinix A-Side Network Type | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | `""` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_role"></a> [role](#input\_role) | Role of network | `string` | n/a | yes |
| <a name="input_service_token_description"></a> [service\_token\_description](#input\_service\_token\_description) | Service Token Description | `string` | n/a | yes |
| <a name="input_service_token_expiration_date_time"></a> [service\_token\_expiration\_date\_time](#input\_service\_token\_expiration\_date\_time) | Expiration date and time of the service token; 2020-11-06T07:00:00 | `string` | n/a | yes |
| <a name="input_service_token_name"></a> [service\_token\_name](#input\_service\_token\_name) | Service Token Name | `string` | n/a | yes |
| <a name="input_service_token_type"></a> [service\_token\_type](#input\_service\_token\_type) | Service Token Type; VC\_TOKEN,EPL\_TOKEN | `string` | n/a | yes |
| <a name="input_supported_bandwidths"></a> [supported\_bandwidths](#input\_supported\_bandwidths) | List of permitted bandwidths | `list` | `[]` | no |
| <a name="input_term_length"></a> [term\_length](#input\_term\_length) | Order Term Length | `number` | `1` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Type of Access point; COLO, VD, NETWORK | `string` | n/a | yes |
| <a name="input_zside_network_type"></a> [zside\_network\_type](#input\_zside\_network\_type) | Network type | `string` | n/a | yes |
| <a name="input_zside_network_uuid"></a> [zside\_network\_uuid](#input\_zside\_network\_uuid) | Network UUID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_etree_network"></a> [etree\_network](#output\_etree\_network) | n/a |
| <a name="output_etree_network_id"></a> [etree\_network\_id](#output\_etree\_network\_id) | n/a |
| <a name="output_port_2_network_service_token_connection_id"></a> [port\_2\_network\_service\_token\_connection\_id](#output\_port\_2\_network\_service\_token\_connection\_id) | n/a |
| <a name="output_port_connection"></a> [port\_connection](#output\_port\_connection) | n/a |
| <a name="output_service-token"></a> [service-token](#output\_service-token) | n/a |
| <a name="output_service_token_id"></a> [service\_token\_id](#output\_service\_token\_id) | n/a |
<!-- END_TF_DOCS -->
