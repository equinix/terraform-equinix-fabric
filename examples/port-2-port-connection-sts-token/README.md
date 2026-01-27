# Fabric Port to Fabric Port Connection

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Port.

It leverages the Equinix Terraform Provider for STS token, and the Fabric Port Connection
Module to setup the connection based on the parameters you have provided to this example; or based on the pattern
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
cd terraform-equinix-fabric/examples/port-2-port-connection-sts-token
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
sts_source_token      = "<STSSourceToken>"
sts_auth_scope        = "<STSAuthScope>"

connection_name       = "Port2Port"
connection_type       = "EVPL_VC"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com", "test1@equinix.com"]
bandwidth             = 50
purchase_order_number = "1-226892"
aside_port_uuid       = "<Fabric Aside Port UUID>"
aside_vlan_tag        = "1976"
zside_ap_type         = "COLO"
zside_port_uuid       = "<Fabric Zside Port UUID>"
zside_vlan_tag        = "3711"
zside_location        = "SV"
```

versions.tf
```hcl
terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 4.7.0"
    }
  }
}
```

variables.tf
 ```hcl
variable "sts_source_token" {
  description = "Equinix STS Source Token, the ID token generated using: python -m oidcsim idtoken --sub {username}"
  type        = string
  sensitive   = true
}
variable "sts_auth_scope" {
  description = "Equinix STS Source Token Authentication Scope in the format: roleassignments:{rootOrg}"
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
variable "aside_port_uuid" {
  description = "Equinix A-Side Port UUID"
  type        = string
  default = ""
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
variable "aside_vlan_inner_tag" {
  description = "Vlan Inner Tag information, inner vlanCTag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_port_uuid" {
  description = "Equinix Port UUID"
  type        = string
  default     = ""
}
variable "zside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
```

outputs.tf
```hcl
output "port_connection" {
  value = module.create_port_2_port_connection.primary_connection
  sensitive = true
}

output "port_connection_id" {
  value = module.create_port_2_port_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  token_exchange_subject_token = var.sts_source_token
  token_exchange_scope = var.sts_auth_scope
}

module "create_port_2_port_connection" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_uuid = var.aside_port_uuid
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type   = var.zside_ap_type
  zside_port_uuid = var.zside_port_uuid
  zside_vlan_tag  = var.zside_vlan_tag
  zside_location  = var.zside_location
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 4.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_port_connection"></a> [create\_port\_2\_port\_connection](#module\_create\_port\_2\_port\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_port_uuid"></a> [aside\_port\_uuid](#input\_aside\_port\_uuid) | Equinix A-Side Port UUID | `string` | `""` | no |
| <a name="input_aside_vlan_inner_tag"></a> [aside\_vlan\_inner\_tag](#input\_aside\_vlan\_inner\_tag) | Vlan Inner Tag information, inner vlanCTag for QINQ connections | `string` | `""` | no |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_sts_auth_scope"></a> [sts\_auth\_scope](#input\_sts\_auth\_scope) | Equinix STS Source Token Authentication Scope in the format: roleassignments:{rootOrg} | `string` | n/a | yes |
| <a name="input_sts_source_token"></a> [sts\_source\_token](#input\_sts\_source\_token) | Equinix STS Source Token, the ID token generated using: python -m oidcsim idtoken --sub {username} | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_port_uuid"></a> [zside\_port\_uuid](#input\_zside\_port\_uuid) | Equinix Port UUID | `string` | `""` | no |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_port_connection"></a> [port\_connection](#output\_port\_connection) | n/a |
| <a name="output_port_connection_id"></a> [port\_connection\_id](#output\_port\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
