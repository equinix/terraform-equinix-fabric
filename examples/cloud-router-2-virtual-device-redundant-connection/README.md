# Fabric Cloud Router to Virtual Device Redundant Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](../../modules/cloud-router-connection/README.md)
to create a Fabric Connection from a Fabric Cloud Router to Virtual Devices using two connections.A Primary and secondary connection.

It leverages the Equinix Terraform Provider and the Fabric Cloud Router Connection
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
cd terraform-equinix-fabric/examples/cloud-router-2-virtual-device-redundant-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id           = "<MyEquinixClientId>"
equinix_client_secret       = "<MyEquinixSecret>"

notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com", "test1@equinix.com"]
purchase_order_number       = "1-323292"
aside_fcr_uuid              = "<Fabric Cloud Router UUID>"
connection_name             = "FCR_2_VD_Pri"
connection_type             = "IP_VC"
bandwidth                   = 50

zside_ap_type               = "VD"
zside_vd_type               = "EDGE"
zside_vd_uuid               = "<Primary Virtual Device UUID>"
zside_interface_type        = "NETWORK"
zside_interface_id          = 5

secondary_connection_name   = "FCR_2_VD_sec"
secondary_bandwidth         = 50
zside_vd_sec_uuid           = "<Secondary Virtual Device UUID>"
zside_sec_interface_type    = "NETWORK"
zside_sec_interface_id      = 2
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.31.0"
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
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "VD"
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
  description = "Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_interface_id" {
  description = "Interface Id"
  type        = number
  default     = null
}
variable "secondary_connection_name" {
  description = "Secondary Connection name"
  type        = string
}
variable "secondary_bandwidth" {
  description = "Secondary Connection bandwidth in Mbps"
  type        = number
  default     = 50
}
variable "zside_sec_vd_uuid" {
  description = "Secondary Virtual Device UUID"
  type        = string
}
variable "zside_sec_interface_type" {
  description = "Secondary Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_sec_interface_id" {
  description = "Secondary Interface Id"
  type        = number
  default     = null
}
```

outputs.tf
```hcl
output "FCR_VD_Primary_Connection" {
  value = module.cloud_router_virtual_device_redundant_connection.primary_connection_id
}
output "FCR_VD_Secondary_Connection" {
  value = module.cloud_router_virtual_device_redundant_connection.secondary_connection_id
}

```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_virtual_device_redundant_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type        = var.zside_ap_type
  zside_vd_type        = var.zside_vd_type
  zside_vd_uuid        = var.zside_vd_uuid
  zside_interface_type = var.zside_interface_type
  zside_interface_id   = var.zside_interface_id

  #Secondary-Connection
  secondary_connection_name = var.secondary_connection_name
  secondary_bandwidth       = var.secondary_bandwidth
  zside_sec_vd_uuid         = var.zside_sec_vd_uuid
  zside_sec_interface_type  = var.zside_sec_interface_type
  zside_sec_interface_id    = var.zside_sec_interface_id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.31.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_virtual_device_redundant_connection"></a> [cloud\_router\_virtual\_device\_redundant\_connection](#module\_cloud\_router\_virtual\_device\_redundant\_connection) | ../../modules/cloud-router-connection | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Secondary Connection bandwidth in Mbps | `number` | `50` | no |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"VD"` | no |
| <a name="input_zside_interface_id"></a> [zside\_interface\_id](#input\_zside\_interface\_id) | Interface Id | `number` | `null` | no |
| <a name="input_zside_interface_type"></a> [zside\_interface\_type](#input\_zside\_interface\_type) | Virtual Device Interface type - CLOUD, NETWORK | `string` | `""` | no |
| <a name="input_zside_sec_interface_id"></a> [zside\_sec\_interface\_id](#input\_zside\_sec\_interface\_id) | Secondary Interface Id | `number` | `null` | no |
| <a name="input_zside_sec_interface_type"></a> [zside\_sec\_interface\_type](#input\_zside\_sec\_interface\_type) | Secondary Virtual Device Interface type - CLOUD, NETWORK | `string` | `""` | no |
| <a name="input_zside_sec_vd_uuid"></a> [zside\_sec\_vd\_uuid](#input\_zside\_sec\_vd\_uuid) | Secondary Virtual Device UUID | `string` | n/a | yes |
| <a name="input_zside_vd_type"></a> [zside\_vd\_type](#input\_zside\_vd\_type) | Virtual Device type - EDGE | `string` | n/a | yes |
| <a name="input_zside_vd_uuid"></a> [zside\_vd\_uuid](#input\_zside\_vd\_uuid) | Virtual Device UUID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_FCR_VD_Primary_Connection"></a> [FCR\_VD\_Primary\_Connection](#output\_FCR\_VD\_Primary\_Connection) | n/a |
| <a name="output_FCR_VD_Secondary_Connection"></a> [FCR\_VD\_Secondary\_Connection](#output\_FCR\_VD\_Secondary\_Connection) | n/a |
<!-- END_TF_DOCS -->
