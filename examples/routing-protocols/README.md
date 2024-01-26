# Fabric Routing Protocols Addition to Fabric Connection

This example shows how to leverage the [Fabric Routing Protocols Module](../../modules/routing-protocols/README.md)
to create Routing Protocols for a Fabric Connection.

It leverages the Equinix Terraform Provider, and the Fabric Routing Protocols
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
cd terraform-equinix-fabric/examples/routing-protocols
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl

equinix_client_id     = "<MyEquinixClientId>"
equinix_client_secret = "<MyEquinixSecret>"

connection_uuid        = "<Equinix_Connection_UUID>"

direct_rp_name         = "DIRECT_RP"
direct_equinix_ipv4_ip = "190.1.1.1/30"
direct_equinix_ipv6_ip = "190::1:1/126"

bgp_rp_name            = "BGP_RP"
bgp_customer_peer_ipv4 = "190.1.1.2"
bgp_customer_peer_ipv6 = "190::1:2"
bgp_enabled_ipv4       = true
bgp_enabled_ipv6       = true
bgp_customer_asn       = "100"
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

variable "connection_uuid" {
  description = "Equinix Connection UUID to Apply the Routing Protocols to"
  type        = string
}
variable "direct_rp_name" {
  description = "Name of the Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv4_ip" {
  description = "IPv4 Address for Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv6_ip" {
  description = "IPv6 Address for Direct Routing Protocol"
  type        = string
}


variable "bgp_rp_name" {
  description = "Name of the BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv4" {
  description = "Customer Peering IPv4 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv6" {
  description = "Customer Peering IPv6 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_enabled_ipv4" {
  description = "Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_enabled_ipv6" {
  description = "Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_customer_asn" {
  description = "Customer ASN for BGP Routing Protocol"
  type        = string
  default     = ""
}
```
outputs.tf:
```hcl

output "direct_rp_id" {
  value = module.routing_protocols.direct_routing_protocol_id
}

output "bgp_rp_id" {
  value = module.routing_protocols.bgp_routing_protocol_id
}
```
main.tf:
```hcl

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "routing_protocols" {
  source = "equinix/fabric/equinix//modules/routing-protocols"

  connection_uuid = var.connection_uuid

  # Direct RP Details
  direct_rp_name         = var.direct_rp_name
  direct_equinix_ipv4_ip = var.direct_equinix_ipv4_ip
  direct_equinix_ipv6_ip = var.direct_equinix_ipv6_ip

  # BGP RP Details
  bgp_rp_name            = var.bgp_rp_name
  bgp_customer_asn       = var.bgp_customer_asn
  bgp_customer_peer_ipv4 = var.bgp_customer_peer_ipv4
  bgp_enabled_ipv4       = var.bgp_enabled_ipv4
  bgp_customer_peer_ipv6 = var.bgp_customer_peer_ipv6
  bgp_enabled_ipv6       = var.bgp_enabled_ipv6
}
```
<!-- End Example Usage -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_routing_protocols"></a> [routing\_protocols](#module\_routing\_protocols) | ../../modules/routing-protocols | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_uuid"></a> [connection\_uuid](#input\_connection\_uuid) | Equinix Connection UUID to Apply the Routing Protocols to | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv4_ip"></a> [direct\_equinix\_ipv4\_ip](#input\_direct\_equinix\_ipv4\_ip) | IPv4 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv6_ip"></a> [direct\_equinix\_ipv6\_ip](#input\_direct\_equinix\_ipv6\_ip) | IPv6 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_direct_rp_name"></a> [direct\_rp\_name](#input\_direct\_rp\_name) | Name of the Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_bgp_customer_asn"></a> [bgp\_customer\_asn](#input\_bgp\_customer\_asn) | Customer ASN for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv4"></a> [bgp\_customer\_peer\_ipv4](#input\_bgp\_customer\_peer\_ipv4) | Customer Peering IPv4 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv6"></a> [bgp\_customer\_peer\_ipv6](#input\_bgp\_customer\_peer\_ipv6) | Customer Peering IPv6 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_enabled_ipv4"></a> [bgp\_enabled\_ipv4](#input\_bgp\_enabled\_ipv4) | Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_enabled_ipv6"></a> [bgp\_enabled\_ipv6](#input\_bgp\_enabled\_ipv6) | Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_rp_name"></a> [bgp\_rp\_name](#input\_bgp\_rp\_name) | Name of the BGP Routing Protocol | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bgp_rp_id"></a> [bgp\_rp\_id](#output\_bgp\_rp\_id) | n/a |
| <a name="output_direct_rp_id"></a> [direct\_rp\_id](#output\_direct\_rp\_id) | n/a |
<!-- END_TF_DOCS -->
