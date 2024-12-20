# Fabric Port to Fabric Oracle Service Profile Connection

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Oracle Service Profile.

It leverages the Equinix Terraform Provider, and the Fabric Port Connection
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
cd terraform-equinix-fabric/examples/port-2-oracle-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

connection_name             = "Port2Oracle"
connection_type             = "EVPL_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
bandwidth                   = 1000
purchase_order_number       = "1-323292"
aside_port_name             = "sit-tb1-dc-e5.tlab,10GSMF,A,001,201257, 21951980"
aside_vlan_tag              = "2019"
aside_vlan_inner_tag        = "2020"
zside_ap_type               = "SP"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "DC"
zside_sp_name               = "Oracle Cloud Infrastructure -OCI- FastConnect"

oracle_tenancy_ocid             = "<Oracle Tenancy OCID>"
oracle_user_ocid                = "<Oracle User OCID>"
oracle_private_key              = "<Oracle Private Key>"
oracle_fingerprint              = "<Oracle Fingerprint>"
oracle_region                   = "us-sanjose-1"
oracle_compartment_id           = "<Oracle Compartment ID>",
oracle_fastconnect_provider     = "Equinix"
oracle_vc_display_name          = "Port2Oracle"
oracle_vc_type                  = "PRIVATE"
oracle_bandwidth                = "1 Gbps"
oracle_customer_bgp_peering_ip  = "10.1.0.50/30"
oracle_bgp_peering_ip           = "10.1.0.49/30"
oracle_customer_asn             = "123456"
oracle_gateway_id               = "<Oracle Gateway ID>"
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
    oci = {
      source = "oracle/oci"
      version = ">= 5.36.0"
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
variable "aside_port_name" {
  description = "Equinix A-Side Port Name"
  type        = string
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
variable "oracle_tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
  sensitive   = true
}
variable "oracle_user_ocid" {
  description = "User OCID"
  type        = string
  sensitive   = true
}
variable "oracle_private_key" {
  description = "Oracle Private key"
  type        = string
}
variable "oracle_fingerprint" {
  description = "Fingerprint for the key pair being used"
  type        = string
  sensitive   = true
}
variable "oracle_region" {
  description = "OCI region"
  type        = string
}
variable "oracle_compartment_id" {
  description = "The OCID of the compartment"
  type        = string
  sensitive   = true
}
variable "oracle_fastconnect_provider" {
  description = "Fast Connect Provider Name"
  type        = string
}
variable "oracle_vc_display_name" {
  description = "OCI Virtual Circuit Name"
  type        = string
}
variable "oracle_vc_type" {
  description = "The type of IP addresses used in this virtual circuit - PRIVATE"
  type        = string
}
variable "oracle_bandwidth" {
  description = "The provisioned connection bandwidth"
  type        = string
}
variable "oracle_customer_bgp_peering_ip" {
  description = "The BGP IPv4 address for the router on the other end of the BGP session from Oracle"
  type        = string
}
variable "oracle_bgp_peering_ip" {
  description = "The BGP IPv6 address for the router on the other end of the BGP session from Oracle"
  type        = string
}
variable "oracle_customer_asn" {
  description = "Oracle BGP ASN"
  type        = string
}
variable "oracle_gateway_id" {
  description = "The OCID of the dynamic routing gateway (DRG) that virtual circuit uses"
  type        = string
}
```

outputs.tf
```hcl
output "oracle_connection" {
  value = module.create_port_2_oracle_connection.primary_connection
  sensitive = true
}

output "oracle_connection_id" {
  value = module.create_port_2_oracle_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
provider "oci" {
  tenancy_ocid      = var.oracle_tenancy_ocid
  user_ocid         = var.oracle_user_ocid
  private_key       = var.oracle_private_key
  fingerprint       = var.oracle_fingerprint
  region            = var.oracle_region
}

data "oci_core_fast_connect_provider_services" "fc_provider_services" {
  compartment_id = var.oracle_compartment_id
}

locals {
  fc_provider_services_id = element(
    data.oci_core_fast_connect_provider_services.fc_provider_services.fast_connect_provider_services,
    index(
      data.oci_core_fast_connect_provider_services.fc_provider_services.fast_connect_provider_services.*.provider_name,
      var.oracle_fastconnect_provider
    )
  ).id
}

resource "oci_core_virtual_circuit" "test_virtual_circuit" {
  display_name          = var.oracle_vc_display_name
  compartment_id        = var.oracle_compartment_id
  type                  = var.oracle_vc_type
  bandwidth_shape_name  = var.oracle_bandwidth
  cross_connect_mappings {
    customer_bgp_peering_ip = var.oracle_customer_bgp_peering_ip
    oracle_bgp_peering_ip   = var.oracle_bgp_peering_ip
  }
  customer_asn        = var.oracle_customer_asn
  region              = var.oracle_region
  provider_service_id = local.fc_provider_services_id
  gateway_id          = var.oracle_gateway_id
}

module "create_port_2_oracle_connection" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = oci_core_virtual_circuit.test_virtual_circuit.id
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.oracle_region
  zside_sp_name               = var.zside_sp_name
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 5.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 5.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_oracle_connection"></a> [create\_port\_2\_oracle\_connection](#module\_create\_port\_2\_oracle\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_core_virtual_circuit.test_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_virtual_circuit) | resource |
| [oci_core_fast_connect_provider_services.fc_provider_services](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_fast_connect_provider_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_vlan_inner_tag"></a> [aside\_vlan\_inner\_tag](#input\_aside\_vlan\_inner\_tag) | Vlan Inner Tag information, inner vlanCTag for QINQ connections | `string` | `""` | no |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_oracle_bandwidth"></a> [oracle\_bandwidth](#input\_oracle\_bandwidth) | The provisioned connection bandwidth | `string` | n/a | yes |
| <a name="input_oracle_bgp_peering_ip"></a> [oracle\_bgp\_peering\_ip](#input\_oracle\_bgp\_peering\_ip) | The BGP IPv6 address for the router on the other end of the BGP session from Oracle | `string` | n/a | yes |
| <a name="input_oracle_compartment_id"></a> [oracle\_compartment\_id](#input\_oracle\_compartment\_id) | The OCID of the compartment | `string` | n/a | yes |
| <a name="input_oracle_customer_asn"></a> [oracle\_customer\_asn](#input\_oracle\_customer\_asn) | Oracle BGP ASN | `string` | n/a | yes |
| <a name="input_oracle_customer_bgp_peering_ip"></a> [oracle\_customer\_bgp\_peering\_ip](#input\_oracle\_customer\_bgp\_peering\_ip) | The BGP IPv4 address for the router on the other end of the BGP session from Oracle | `string` | n/a | yes |
| <a name="input_oracle_fastconnect_provider"></a> [oracle\_fastconnect\_provider](#input\_oracle\_fastconnect\_provider) | Fast Connect Provider Name | `string` | n/a | yes |
| <a name="input_oracle_fingerprint"></a> [oracle\_fingerprint](#input\_oracle\_fingerprint) | Fingerprint for the key pair being used | `string` | n/a | yes |
| <a name="input_oracle_gateway_id"></a> [oracle\_gateway\_id](#input\_oracle\_gateway\_id) | The OCID of the dynamic routing gateway (DRG) that virtual circuit uses | `string` | n/a | yes |
| <a name="input_oracle_private_key"></a> [oracle\_private\_key](#input\_oracle\_private\_key) | Oracle Private key | `string` | n/a | yes |
| <a name="input_oracle_region"></a> [oracle\_region](#input\_oracle\_region) | OCI region | `string` | n/a | yes |
| <a name="input_oracle_tenancy_ocid"></a> [oracle\_tenancy\_ocid](#input\_oracle\_tenancy\_ocid) | Tenancy OCID | `string` | n/a | yes |
| <a name="input_oracle_user_ocid"></a> [oracle\_user\_ocid](#input\_oracle\_user\_ocid) | User OCID | `string` | n/a | yes |
| <a name="input_oracle_vc_display_name"></a> [oracle\_vc\_display\_name](#input\_oracle\_vc\_display\_name) | OCI Virtual Circuit Name | `string` | n/a | yes |
| <a name="input_oracle_vc_type"></a> [oracle\_vc\_type](#input\_oracle\_vc\_type) | The type of IP addresses used in this virtual circuit - PRIVATE | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oracle_connection"></a> [oracle\_connection](#output\_oracle\_connection) | n/a |
| <a name="output_oracle_connection_id"></a> [oracle\_connection\_id](#output\_oracle\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
