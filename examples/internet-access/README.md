# Equinix Fabric Internet Access

Creates an Internet Access (EIA) service through `modules/internet-access`. `terraform destroy` removes it at the end.

The module creates an `IA_VC` connection from `port_uuid` to the Equinix Internet Access service profile, an IP block used as a customer route, and the service attached to both.
The VLAN tag of the connection is generated with `modules/random-vlan-tag`.
For BGP the service can use an existing ASN (`asn_uuid`).

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
cd terraform-equinix-fabric/examples/internet-access
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id     = "<client_id>"
equinix_client_secret = "<client_secret>"

name                  = "tf-ia-service"
type                  = "SINGLE_IA"
project_id            = "<project_id>"
account_number        = "<account_number>"
billing_type          = "FIXED"
bandwidth             = 100
# purchase_order_number = "<po_number>"

port_uuid            = "<port_uuid>"
service_profile_uuid = "<ia_profile_uuid>"
metro_code           = "MX"

connection_name        = "tf-ia-connection"
ip_block_type          = "IPV4_IP_BLOCK"
connection_bandwidth   = 50
notifications_emails   = ["example@equinix.com"]
ip_block_prefix_length = 30

routing_protocol_type = "DIRECT"

# BGP only
# routing_protocol_type = "BGP"
# asn_uuid              = "<equinix_fabric_asn uuid>"
# customer_asn          = 65001
# customer_asn_range    = "BITS_16"
# export_policy         = "FULL"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 5.4.0"
    }
  }
}
```

variables.tf
 ```hcl
variable "equinix_client_id" {
  description = "API Consumer Key available under 'My Apps' in developer portal"
  type        = string
}

variable "equinix_client_secret" {
  description = "API Consumer secret available under 'My Apps' in developer portal"
  type        = string
  sensitive   = true
}

variable "name" {
  description = "The name of the EIA service"
  type        = string
}

variable "type" {
  description = "Type of the EIA service. One of: SINGLE_IA, DUAL_IA"
  type        = string
}

variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
}

variable "account_number" {
  description = "Account number"
  type        = string
}

variable "billing_type" {
  description = "Billing type of the EIA service. One of: FIXED, USAGE_BASED, BURST_BASED"
  type        = string
}

variable "bandwidth" {
  description = "Bandwidth of the service"
  type        = number
}

variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = null
}

variable "routing_protocol_type" {
  description = "Routing protocol type. One of: BGP, DIRECT, STATIC"
  type        = string
}

variable "port_uuid" {
  description = "UUID of the Fabric port the IA_VC connection starts from"
  type        = string
}

variable "service_profile_uuid" {
  description = "UUID of the Equinix Internet Access service profile (IA_PROFILE)"
  type        = string
}

variable "metro_code" {
  description = "Two-letter metro code of the port and the service profile"
  type        = string
}

variable "connection_name" {
  description = "Name of the IA_VC connection created for the service"
  type        = string
}

variable "connection_bandwidth" {
  description = "Bandwidth of the IA_VC connection in Mbps"
  type        = number
}

variable "asn_uuid" {
  description = "BGP only. Unique identifier of the ASN (equinix_fabric_asn)"
  type        = string
  default     = null
}

variable "customer_asn" {
  description = "BGP only. Customer ASN. Valid range is 1-64495 or 65536-4199999999"
  type        = number
  default     = null
}

variable "customer_asn_range" {
  description = "BGP only. Customer ASN range. One of: BITS_16, BITS_32"
  type        = string
  default     = null
}

variable "bgp_auth_key" {
  description = "BGP only. BGP authentication key"
  type        = string
  default     = null
  sensitive   = true
}

variable "export_policy" {
  description = "BGP only. Export policy. One of: FULL, DEFAULT, FULL_DEFAULT, PARTIAL"
  type        = string
  default     = null
}


variable "notifications_emails" {
  description = "Emails notified about the Internet Access connection"
  type        = list(string)
}

variable "ip_block_prefix_length" {
  description = "Prefix length of the IP block attached as the customer route"
  type        = number
}

variable "ip_block_type" {
  description = "Type of the IP block used as the customer route. One of: IPV4_IP_BLOCK, IPV6_IP_BLOCK"
  type        = string
}
```

outputs.tf
```hcl
output "internet_access_service_id" {
  description = "UUID of the created Internet Access service"
  value       = module.internet_access.uuid
}

output "internet_access_service_state" {
  description = "Provisioning state of the service"
  value       = module.internet_access.state
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vlan_tag" {
  source = "equinix/fabric/equinix//modules/random-vlan-tag"
}

module "internet_access" {
  source = "equinix/fabric/equinix//modules/internet-access"

  name                   = var.name
  type                   = var.type
  project_id             = var.project_id
  account_number         = var.account_number
  billing_type           = var.billing_type
  bandwidth              = var.bandwidth
  purchase_order_number  = var.purchase_order_number
  routing_protocol_type  = var.routing_protocol_type
  vlan_tag               = module.vlan_tag.result
  port_uuid              = var.port_uuid
  service_profile_uuid   = var.service_profile_uuid
  metro_code             = var.metro_code
  connection_name        = var.connection_name
  connection_bandwidth   = var.connection_bandwidth
  notifications_emails   = var.notifications_emails
  ip_block_type          = var.ip_block_type
  ip_block_prefix_length = var.ip_block_prefix_length
  asn_uuid               = var.asn_uuid
  customer_asn           = var.customer_asn
  customer_asn_range     = var.customer_asn_range
  bgp_auth_key           = var.bgp_auth_key
  export_policy          = var.export_policy
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 5.4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_internet_access"></a> [internet\_access](#module\_internet\_access) | equinix/fabric/equinix//modules/internet-access | n/a |
| <a name="module_vlan_tag"></a> [vlan\_tag](#module\_vlan\_tag) | equinix/fabric/equinix//modules/random-vlan-tag | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number | `string` | n/a | yes |
| <a name="input_asn_uuid"></a> [asn\_uuid](#input\_asn\_uuid) | BGP only. Unique identifier of the ASN (equinix\_fabric\_asn) | `string` | `null` | no |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth of the service | `number` | n/a | yes |
| <a name="input_bgp_auth_key"></a> [bgp\_auth\_key](#input\_bgp\_auth\_key) | BGP only. BGP authentication key | `string` | `null` | no |
| <a name="input_billing_type"></a> [billing\_type](#input\_billing\_type) | Billing type of the EIA service. One of: FIXED, USAGE\_BASED, BURST\_BASED | `string` | n/a | yes |
| <a name="input_connection_bandwidth"></a> [connection\_bandwidth](#input\_connection\_bandwidth) | Bandwidth of the IA\_VC connection in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Name of the IA\_VC connection created for the service | `string` | n/a | yes |
| <a name="input_customer_asn"></a> [customer\_asn](#input\_customer\_asn) | BGP only. Customer ASN. Valid range is 1-64495 or 65536-4199999999 | `number` | `null` | no |
| <a name="input_customer_asn_range"></a> [customer\_asn\_range](#input\_customer\_asn\_range) | BGP only. Customer ASN range. One of: BITS\_16, BITS\_32 | `string` | `null` | no |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | API Consumer Key available under 'My Apps' in developer portal | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | API Consumer secret available under 'My Apps' in developer portal | `string` | n/a | yes |
| <a name="input_export_policy"></a> [export\_policy](#input\_export\_policy) | BGP only. Export policy. One of: FULL, DEFAULT, FULL\_DEFAULT, PARTIAL | `string` | `null` | no |
| <a name="input_ip_block_prefix_length"></a> [ip\_block\_prefix\_length](#input\_ip\_block\_prefix\_length) | Prefix length of the IP block attached as the customer route | `number` | n/a | yes |
| <a name="input_ip_block_type"></a> [ip\_block\_type](#input\_ip\_block\_type) | Type of the IP block used as the customer route. One of: IPV4\_IP\_BLOCK, IPV6\_IP\_BLOCK | `string` | n/a | yes |
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code) | Two-letter metro code of the port and the service profile | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the EIA service | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Emails notified about the Internet Access connection | `list(string)` | n/a | yes |
| <a name="input_port_uuid"></a> [port\_uuid](#input\_port\_uuid) | UUID of the Fabric port the IA\_VC connection starts from | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `null` | no |
| <a name="input_routing_protocol_type"></a> [routing\_protocol\_type](#input\_routing\_protocol\_type) | Routing protocol type. One of: BGP, DIRECT, STATIC | `string` | n/a | yes |
| <a name="input_service_profile_uuid"></a> [service\_profile\_uuid](#input\_service\_profile\_uuid) | UUID of the Equinix Internet Access service profile (IA\_PROFILE) | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Type of the EIA service. One of: SINGLE\_IA, DUAL\_IA | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_internet_access_service_id"></a> [internet\_access\_service\_id](#output\_internet\_access\_service\_id) | UUID of the created Internet Access service |
| <a name="output_internet_access_service_state"></a> [internet\_access\_service\_state](#output\_internet\_access\_service\_state) | Provisioning state of the service |
<!-- END_TF_DOCS -->