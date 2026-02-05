# Fabric Cloud Router to Alibaba Service Profile Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-connection)
to create a Fabric Connection from a Fabric Cloud Router to Alibaba Service Profile.

It leverages the Equinix Terraform Provider, the Alibaba Terraform Provider, the Fabric Port Connection Module and Fabric Routing Protocols module to setup the connection based on the parameters you have provided to this example; or based on the pattern you see used in this example it will allow you to create a more specific use case for your own needs.

For complete Connection creation, the connection needs to be accepted on Alibaba portal. Please refer from step 3 of the [Port to ALibaba connection example](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/examples/port-2-alibaba-connection-with-alicloud-terraform-integration)

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
cd terraform-equinix-fabric/examples/cloud-router-2-alibaba-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

connection_name             = "FCR_2_alibaba"
connection_type             = "IP_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
bandwidth                   = 50
purchase_order_number       = "1-323292"
aside_fcr_uuid              = "<Fabric Cloud Router UUID>"
zside_ap_type               = "SP"
zside_ap_authentication_key = "<Alibaba Auth Key>"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SY"
zside_sp_name               = "Alibaba Cloud Express Connect"
zside_seller_region         = "ap-southeast-2"

routing_protocol_direct_ipv4_ip     = "190.1.1.1/30"
routing_protocol_direct_rp_name     = "DIRECT_RP"
routing_protocol_bgp_rp_name        = "BGP_RP"
routing_protocol_bgp_customer_asn   = "100"
routing_protocol_bgp_ipv4_ip        =  "190.1.1.2"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.9.0"
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
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  sensitive   = true
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
}
variable "routing_protocol_direct_rp_name" {
  description = "Name of the Direct Routing Protocol Added to the Cloud Router Connection"
  type        = string
}
variable "routing_protocol_direct_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type        = string
}
variable "routing_protocol_bgp_rp_name" {
  description = "Ipv4 Ip address for Cloud Router Bgp Routing Protocol"
}
variable "routing_protocol_bgp_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type        = string
}
variable "routing_protocol_bgp_customer_asn" {
  description = "Customer ASN number for BGP Routing Protocol"
  type        = number
}
```

outputs.tf
```hcl
output "alibaba_connection" {
  value     = module.create_fcr_2_alibaba_connection.primary_connection
  sensitive = true
}

output "alibaba_connection_id" {
  value = module.create_fcr_2_alibaba_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "create_fcr_2_alibaba_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_sp_name
}

module "cloud_router_connection_routing_protocols" {
  source                 = "equinix/fabric/equinix//modules/cloud-router-routing-protocols"
  connection_uuid        = module.create_fcr_2_alibaba_connection.primary_connection_id
  direct_rp_name         = var.routing_protocol_direct_rp_name
  direct_equinix_ipv4_ip = var.routing_protocol_direct_ipv4_ip
  bgp_rp_name            = var.routing_protocol_bgp_rp_name
  bgp_customer_peer_ipv4 = var.routing_protocol_bgp_ipv4_ip
  bgp_customer_asn       = var.routing_protocol_bgp_customer_asn
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_connection_routing_protocols"></a> [cloud\_router\_connection\_routing\_protocols](#module\_cloud\_router\_connection\_routing\_protocols) | equinix/fabric/equinix//modules/cloud-router-routing-protocols | n/a |
| <a name="module_create_fcr_2_alibaba_connection"></a> [create\_fcr\_2\_alibaba\_connection](#module\_create\_fcr\_2\_alibaba\_connection) | equinix/fabric/equinix//modules/cloud-router-connection | n/a |

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
| <a name="input_routing_protocol_bgp_customer_asn"></a> [routing\_protocol\_bgp\_customer\_asn](#input\_routing\_protocol\_bgp\_customer\_asn) | Customer ASN number for BGP Routing Protocol | `number` | n/a | yes |
| <a name="input_routing_protocol_bgp_ipv4_ip"></a> [routing\_protocol\_bgp\_ipv4\_ip](#input\_routing\_protocol\_bgp\_ipv4\_ip) | Ipv4 Ip address for Cloud Router Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_routing_protocol_bgp_rp_name"></a> [routing\_protocol\_bgp\_rp\_name](#input\_routing\_protocol\_bgp\_rp\_name) | Ipv4 Ip address for Cloud Router Bgp Routing Protocol | `any` | n/a | yes |
| <a name="input_routing_protocol_direct_ipv4_ip"></a> [routing\_protocol\_direct\_ipv4\_ip](#input\_routing\_protocol\_direct\_ipv4\_ip) | Ipv4 Ip address for Cloud Router Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_routing_protocol_direct_rp_name"></a> [routing\_protocol\_direct\_rp\_name](#input\_routing\_protocol\_direct\_rp\_name) | Name of the Direct Routing Protocol Added to the Cloud Router Connection | `string` | n/a | yes |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alibaba_connection"></a> [alibaba\_connection](#output\_alibaba\_connection) | n/a |
| <a name="output_alibaba_connection_id"></a> [alibaba\_connection\_id](#output\_alibaba\_connection\_id) | n/a |
<!-- END_TF_DOCS -->