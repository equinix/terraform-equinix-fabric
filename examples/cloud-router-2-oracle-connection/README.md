# Fabric Cloud Router to Oracle Service Profile Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-connection)
to create a Fabric Connection from a Fabric Cloud Router to Oracle Service Profile.

It leverages the Equinix Terraform Provider, and the Fabric Cloud Router Connection
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
cd terraform-equinix-fabric/examples/examples/cloud-router-2-oracle-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

connection_name                 = "fcr_2_oracle"
connection_type                 = "IP_VC"
notifications_type              = "ALL"
notifications_emails            = ["example@equinix.com","test1@equinix.com"]
purchase_order_number           = "1-323292"
bandwidth                       = 1000
aside_fcr_uuid                  = "<Primary Fabric Cloud router UUID>"
zside_ap_type                   = "SP"
zside_ap_profile_type           = "L2_PROFILE"
zside_location                  = "SV"
zside_peering_type              = "PRIVATE"
zside_fabric_sp_name            = "Oracle Cloud Infrastructure -OCI- FastConnect"

oracle_tenancy_ocid             = "<Oracle Tenancy OCID>"
oracle_user_ocid                = "<Oracle User OCID>"
oracle_private_key              = "<Oracle Private Key>"
oracle_fingerprint              = "<Oracle Fingerprint>"
oracle_region                   = "us-sanjose-1"
oracle_compartment_id           = "<Oracle Compartment ID>",
oracle_fastconnect_provider     = "Equinix"
oracle_vc_display_name          = "FCR2Oracle"
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
      version = ">= 1.36.3"
    }
    oci = {
      source = "oracle/oci"
      version = "5.36.0"
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
  default     = ""
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
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
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
variable "zside_peering_type" {
  description = "Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  default     = "PRIVATE"
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
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
  description = "Oracle Private Key"
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
output "oracle_connection_id" {
  value = module.cloud_router_oracle_connection.primary_connection_id
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

module "cloud_router_oracle_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #A-side
  aside_fcr_uuid = var.aside_fcr_uuid

  #Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = oci_core_virtual_circuit.test_virtual_circuit.id
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_peering_type          = var.zside_peering_type
  zside_seller_region         = var.oracle_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.36.3 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_oracle_connection"></a> [cloud\_router\_oracle\_connection](#module\_cloud\_router\_oracle\_connection) | equinix/fabric/equinix//modules/cloud-router-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [oci_core_virtual_circuit.test_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/5.36.0/docs/resources/core_virtual_circuit) | resource |
| [oci_core_fast_connect_provider_services.fc_provider_services](https://registry.terraform.io/providers/oracle/oci/5.36.0/docs/data-sources/core_fast_connect_provider_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
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
| <a name="input_oracle_private_key"></a> [oracle\_private\_key](#input\_oracle\_private\_key) | Oracle Private Key | `string` | n/a | yes |
| <a name="input_oracle_region"></a> [oracle\_region](#input\_oracle\_region) | OCI region | `string` | n/a | yes |
| <a name="input_oracle_tenancy_ocid"></a> [oracle\_tenancy\_ocid](#input\_oracle\_tenancy\_ocid) | Tenancy OCID | `string` | n/a | yes |
| <a name="input_oracle_user_ocid"></a> [oracle\_user\_ocid](#input\_oracle\_user\_ocid) | User OCID | `string` | n/a | yes |
| <a name="input_oracle_vc_display_name"></a> [oracle\_vc\_display\_name](#input\_oracle\_vc\_display\_name) | OCI Virtual Circuit Name | `string` | n/a | yes |
| <a name="input_oracle_vc_type"></a> [oracle\_vc\_type](#input\_oracle\_vc\_type) | The type of IP addresses used in this virtual circuit - PRIVATE | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | `""` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `"PRIVATE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oracle_connection_id"></a> [oracle\_connection\_id](#output\_oracle\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
