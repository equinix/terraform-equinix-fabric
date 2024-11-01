# Fabric Service Token for Zside Virtual Device Creation Example

This example shows how to create Fabric Zside Virtual Device based Service Token.

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
cd terraform-equinix-fabric/examples/service-token-for-zside-virtual-device
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

#NE Acl Template
template_name           = "test-wan-acl-template"
template_description    = "WAN ACL template"
template_subnet         = "172.16.25.0/24"
template_protocol       = "TCP"
template_src_port       = "any"
template_dst_port       = "22"

#Network Edge
ne_name                 = "Terra_Test_router"
ne_metro_code           = "SV"
ne_type_code            = "C8000V"
ne_package_code         = "network-essentials"
ne_notifications        = ["test@eq.com"]
ne_hostname             = "C8KV"
ne_account_number       = "182390403"
ne_version              = "17.11.01a"
ne_core_count           = 2
ne_term_length          = 1

ne_ssh_key_username     = "<SSH_Key_Username>"
ne_ssh_key_name         = "<SSH_Key_Name"

#network_ssh_key
network_public_key_name = "<Public_SSH_Key_Name>"
network_public_key      = "<Public_SSH_Key>"

#Service Token
service_token_type                  = "VC_TOKEN"
service_token_name                  = "Terra_Test_Token"
service_token_description           = "Zside VD Token Test"
service_token_expiration_date_time  = "2024-12-29T06:43:49.980Z"
notifications_type                  = "ALL"
notifications_emails                = ["example@equinix.com"]
connection_type                     = "EVPL_VC"
supported_bandwidths                = [50,100, 500, 1000]
zside_ap_type                       = "VD"
zside_vd_type                       = "EDGE"
zside_vd_uuid                       = "<Virtual_Device_UUID>"
zside_interface_type                = "NETWORK"
zside_interface_id                  = "3"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.10.0"
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

##NE Acl Template
variable "template_name" {
  description = "ACL Template Name"
  type        = string
}
variable "template_description" {
  description = "ACL Template description"
  type        = string
}
variable "template_subnet" {
  description = "Inbound traffic source IP subnets in CIDR format"
  type        = string
}
variable "template_protocol" {
  description = "Inbound traffic protocol"
  type        = string
}
variable "template_src_port" {
  description = "Inbound traffic source ports"
  type        = string
}
variable "template_dst_port" {
  description = "Inbound traffic destination ports"
  type        = string
}

#Network Edge
variable "ne_name" {
  description = "Device Name"
  type        = string
}
variable "ne_metro_code" {
  description = "Device location metro code"
  type        = string
}
variable "ne_type_code" {
  description = ""
  type        = string
}
variable "ne_package_code" {
  description = "Device software package code"
  type        = string
}
variable "ne_notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
}
variable "ne_hostname" {
  description = "Device hostname prefix"
  type        = string
}
variable "ne_account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}
variable "ne_version" {
  description = "Device software version"
  type        = string
  default     = null
}
variable "ne_core_count" {
  description = "Core count number"
  type        = number
}
variable "ne_term_length" {
  description = "Term length in months"
  type        = number
}
variable "ne_ssh_key_username" {
  description = "username for ssh key"
  type        = string
}
variable "ne_ssh_key_name" {
  description = "ssh key name for device"
  type        = string
}
variable "network_public_key_name" {
  description = "The name of SSH key used for identification."
  type        = string
}
variable "network_public_key" {
  description = "The SSH public key"
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
variable "zside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
variable "zside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_interface_type" {
  description = "Interface Type"
  type        = string
}
variable "zside_interface_id" {
  description = "Interface Id"
  type        = string
}
```

outputs.tf
```hcl
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

#Network Edge Module
resource "equinix_network_acl_template" "wan-acl-template" {
  name        = var.template_name
  description = var.template_description
  inbound_rule {
    subnet   = var.template_subnet
    protocol = var.template_protocol
    src_port = var.template_src_port
    dst_port = var.template_dst_port
  }
}

resource "equinix_network_device" "C8KV-SV" {
  name            = var.ne_name
  metro_code      = var.ne_metro_code
  type_code       = var.ne_type_code
  self_managed    = true
  byol            = true
  package_code    = var.ne_package_code
  notifications   = var.ne_notifications
  hostname        = var.ne_hostname
  account_number  = var.ne_account_number
  version         = var.ne_version
  core_count      = var.ne_core_count
  term_length     = var.ne_term_length

  ssh_key {
    username = var.ne_ssh_key_username
    key_name = var.ne_ssh_key_name
  }
  acl_template_id = equinix_network_acl_template.wan-acl-template.id
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
        virtual_device {
          type = var.zside_vd_type
          uuid = var.zside_vd_uuid
        }
        interface {
          type = var.zside_interface_type
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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_service_token.service-token](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_service_token) | resource |
| [equinix_network_acl_template.wan-acl-template](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_acl_template) | resource |
| [equinix_network_device.C8KV-SV](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Type of Connection supported by Service Token you will create; EVPL\_VC, EVPLAN\_VC, EPLAN\_VC, IPWAN\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_ne_account_number"></a> [ne\_account\_number](#input\_ne\_account\_number) | Billing account number for a device | `string` | `0` | no |
| <a name="input_ne_core_count"></a> [ne\_core\_count](#input\_ne\_core\_count) | Core count number | `number` | n/a | yes |
| <a name="input_ne_hostname"></a> [ne\_hostname](#input\_ne\_hostname) | Device hostname prefix | `string` | n/a | yes |
| <a name="input_ne_metro_code"></a> [ne\_metro\_code](#input\_ne\_metro\_code) | Device location metro code | `string` | n/a | yes |
| <a name="input_ne_name"></a> [ne\_name](#input\_ne\_name) | Device Name | `string` | n/a | yes |
| <a name="input_ne_notifications"></a> [ne\_notifications](#input\_ne\_notifications) | List of email addresses that will receive device status notifications | `list(string)` | n/a | yes |
| <a name="input_ne_package_code"></a> [ne\_package\_code](#input\_ne\_package\_code) | Device software package code | `string` | n/a | yes |
| <a name="input_ne_ssh_key_name"></a> [ne\_ssh\_key\_name](#input\_ne\_ssh\_key\_name) | ssh key name for device | `string` | n/a | yes |
| <a name="input_ne_ssh_key_username"></a> [ne\_ssh\_key\_username](#input\_ne\_ssh\_key\_username) | username for ssh key | `string` | n/a | yes |
| <a name="input_ne_term_length"></a> [ne\_term\_length](#input\_ne\_term\_length) | Term length in months | `number` | n/a | yes |
| <a name="input_ne_type_code"></a> [ne\_type\_code](#input\_ne\_type\_code) | n/a | `string` | n/a | yes |
| <a name="input_ne_version"></a> [ne\_version](#input\_ne\_version) | Device software version | `string` | `null` | no |
| <a name="input_network_public_key"></a> [network\_public\_key](#input\_network\_public\_key) | The SSH public key | `string` | n/a | yes |
| <a name="input_network_public_key_name"></a> [network\_public\_key\_name](#input\_network\_public\_key\_name) | The name of SSH key used for identification. | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | n/a | yes |
| <a name="input_service_token_description"></a> [service\_token\_description](#input\_service\_token\_description) | Service Token Description | `string` | n/a | yes |
| <a name="input_service_token_expiration_date_time"></a> [service\_token\_expiration\_date\_time](#input\_service\_token\_expiration\_date\_time) | Expiration date and time of the service token; 2020-11-06T07:00:00 | `string` | n/a | yes |
| <a name="input_service_token_name"></a> [service\_token\_name](#input\_service\_token\_name) | Service Token Name | `string` | n/a | yes |
| <a name="input_service_token_type"></a> [service\_token\_type](#input\_service\_token\_type) | Service Token Type; VC\_TOKEN,EPL\_TOKEN | `string` | n/a | yes |
| <a name="input_supported_bandwidths"></a> [supported\_bandwidths](#input\_supported\_bandwidths) | List of permitted bandwidths | `list` | n/a | yes |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | ACL Template description | `string` | n/a | yes |
| <a name="input_template_dst_port"></a> [template\_dst\_port](#input\_template\_dst\_port) | Inbound traffic destination ports | `string` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | ACL Template Name | `string` | n/a | yes |
| <a name="input_template_protocol"></a> [template\_protocol](#input\_template\_protocol) | Inbound traffic protocol | `string` | n/a | yes |
| <a name="input_template_src_port"></a> [template\_src\_port](#input\_template\_src\_port) | Inbound traffic source ports | `string` | n/a | yes |
| <a name="input_template_subnet"></a> [template\_subnet](#input\_template\_subnet) | Inbound traffic source IP subnets in CIDR format | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Type of Access point; COLO, VD, NETWORK | `string` | n/a | yes |
| <a name="input_zside_interface_id"></a> [zside\_interface\_id](#input\_zside\_interface\_id) | Interface Id | `string` | n/a | yes |
| <a name="input_zside_interface_type"></a> [zside\_interface\_type](#input\_zside\_interface\_type) | Interface Type | `string` | n/a | yes |
| <a name="input_zside_vd_type"></a> [zside\_vd\_type](#input\_zside\_vd\_type) | Virtual Device type - EDGE | `string` | n/a | yes |
| <a name="input_zside_vd_uuid"></a> [zside\_vd\_uuid](#input\_zside\_vd\_uuid) | Virtual Device UUID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service-token"></a> [service-token](#output\_service-token) | n/a |
<!-- END_TF_DOCS -->
