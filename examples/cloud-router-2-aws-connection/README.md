# Fabric Cloud Router to AWS Service Profile Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](../../modules/cloud-router-connection/README.md)
to create a Fabric Connection from a Fabric Cloud Router to AWS Service Profile.

It leverages the Equinix Terraform Provider, the AWS Terraform Provider, and the Fabric Cloud Router Connection
Module to setup the connection based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

See example usage below for details on how to use this example.

<!-- Begin Example Usage (Do not edit contents) -->
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
cd terraform-equinix-fabric/examples/cloud-router-2-aws-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl

equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com","test1@equinix.com"]
purchase_order_number       = "1-323292"
aside_fcr_uuid              = "<Fabric Cloud Router UUID>"
connection_name             = "fcr_2_aws"
connection_type             = "IP_VC"
bandwidth                   = 50
aside_ap_type               = "CLOUD_ROUTER"
zside_ap_type               = "SP"
zside_ap_authentication_key = "<AWS Account Id>"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_seller_region         = "us-west-1"
zside_fabric_sp_name        = "AWS Direct Connect"
additional_info = [
  { key = "accessKey", value = "<aws_access_key>" },
  { key = "secretKey", value = "<aws_secret_key>" }
]
```
versions.tf:
```hcl

terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.20.0"
    }
  }
}
```
variables.tf:
```hcl

variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
}
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  default     = ""
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
variable "aside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
  default     = "L2_PROFILE"
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = "SP"
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}

variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
}
```
outputs.tf:
```hcl

output "module_output" {
  value = module.cloud_router_aws_connection.primary_connection_id
}
```
main.tf:
```hcl

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_aws_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  additional_info       = var.additional_info
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid
  aside_ap_type  = var.aside_ap_type

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
```
<!-- End Example Usage -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.25.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_aws_connection"></a> [cloud\_router\_aws\_connection](#module\_cloud\_router\_aws\_connection) | ../../modules/cloud-router-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dx_gateway.aws_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_private_virtual_interface.aws_virtual_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [aws_dx_connection.aws_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_aws_gateway_asn"></a> [aws\_gateway\_asn](#input\_aws\_gateway\_asn) | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294 | `number` | n/a | yes |
| <a name="input_aws_gateway_name"></a> [aws\_gateway\_name](#input\_aws\_gateway\_name) | The name of the Gateway | `string` | n/a | yes |
| <a name="input_aws_vif_address_family"></a> [aws\_vif\_address\_family](#input\_aws\_vif\_address\_family) | The address family for the BGP peer. ipv4 or ipv6 | `string` | n/a | yes |
| <a name="input_aws_vif_bgp_asn"></a> [aws\_vif\_bgp\_asn](#input\_aws\_vif\_bgp\_asn) | The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration | `number` | n/a | yes |
| <a name="input_aws_vif_name"></a> [aws\_vif\_name](#input\_aws\_vif\_name) | The name for the virtual interface | `string` | n/a | yes |
| <a name="input_aws_vif_vlan"></a> [aws\_vif\_vlan](#input\_aws\_vif\_vlan) | The VLAN ID | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]` | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aws_vif_amazon_address"></a> [aws\_vif\_amazon\_address](#input\_aws\_vif\_amazon\_address) | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_aws_vif_bgp_auth_key"></a> [aws\_vif\_bgp\_auth\_key](#input\_aws\_vif\_bgp\_auth\_key) | The authentication key for BGP configuration | `string` | `""` | no |
| <a name="input_aws_vif_customer_address"></a> [aws\_vif\_customer\_address](#input\_aws\_vif\_customer\_address) | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_connection_id"></a> [aws\_connection\_id](#output\_aws\_connection\_id) | n/a |
| <a name="output_aws_dx_gateway_id"></a> [aws\_dx\_gateway\_id](#output\_aws\_dx\_gateway\_id) | n/a |
| <a name="output_aws_interface_id"></a> [aws\_interface\_id](#output\_aws\_interface\_id) | n/a |
<!-- END_TF_DOCS -->
