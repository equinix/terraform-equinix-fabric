# Metal to Google Service Profile Connection Example

This example shows how to leverage the [Metal Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/metal-connection)
to create a Fabric Connection from Equinix Metal to Google Service Profile.

It leverages the Equinix Terraform Provider and the Metal Connection
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
cd terraform-equinix-fabric/examples/dir_name
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"
metal_auth_token       = "<Metal_Auth_Token>"

metal_connection_metro      = "sv"
metal_project_id            = "<Metal_Project_ID>"
metal_connection_name       = "Metal-NIMF-connection"
metal_connection_redundancy = "primary"
metal_connection_speed      = "50Mbps"
metal_connection_type       = "shared_port_vlan"
metal_contact_email         = "tfacc@example.com"

connection_name             = "Metal_2_Google"
connection_type             = "EVPL_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
bandwidth                   = 50
purchase_order_number       = "1-323292"
project_id                  = "<Project_ID>"
zside_ap_type               = "SP"
zside_peering_type          = "PRIVATE"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_fabric_sp_name        = "Google Cloud Partner Interconnect Zone 1"

google_project_id                            = "<GCP Project ID>"
google_region                                = "us-west1"
google_zone                                  = "us-west1-a"
google_credentials_path                      = "<GCP KEY FILE NAME>"
google_network_name                          = "tf-test-network"
google_network_mtu                           = "1460"
google_network_auto_create_subnetwork        = true
google_router_name                           = "tf-test-router"
google_router_bgp_asn                        = "16550"
google_interconnect_name                     = "tf-test-interconnect"
google_interconnect_type                     = "PARTNER"
google_interconnect_edge_availability_domain = "AVAILABILITY_DOMAIN_1"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.34.0"
    }
    google = {
      source = "hashicorp/google"
      version = "5.17.0"
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
#Metal Connection
variable "metal_auth_token" {
  description = "Equinix Metal Authentication API Token"
  type        = string
  sensitive   = true
}
variable "metal_connection_metro" {
  description = "Metro where the connection will be created"
  type        = string
}
variable "metal_project_id" {
  description = "Metal Project Name"
  type        = string
}
variable "metal_connection_name" {
  description = "Metal Connection Name"
  type        = string
}
variable "metal_connection_redundancy" {
  description = "Metal Connection redundancy - redundant or primary"
  type        = string
}
variable "metal_connection_speed" {
  description = "Metal Connection speed - one of 50Mbps, 200Mbps, 500Mbps, 1Gbps, 2Gbps, 5Gbps, 10Gbps"
  type        = string
}
variable "metal_connection_type" {
  description = "Metal Connection type - dedicated , shared or shared_port_vlan"
  type        = string
}
variable "metal_contact_email" {
  description = "Preferred email used for communication"
  type        = string
}
#Google Provider
variable "google_region" {
  description = "The Google region to manage resources in"
  type        = string
}
variable "google_project_id" {
  description = "The default Google Project Id to manage resources in"
  type        = string
}
variable "google_zone" {
  description = "The default Google Zone to manage resources in"
  type        = string
}
variable "google_credentials_path" {
  description = "Path to the contents of a service account key file in JSON format"
  type        = string
}
variable "google_network_name" {
  description = "The Google Network Name"
  type        = string
}
variable "google_network_mtu" {
  description = "The Google Network Maximum Transmission Unit in bytes"
  type        = string
}
variable "google_network_auto_create_subnetwork" {
  description = "When set to true, the network is created in auto subnet mode"
  type        = bool
}
variable "google_router_name" {
  description = "The Google Router Name"
  type        = string
}
variable "google_router_bgp_asn" {
  description = "The Google Router Local BGP Autonomous System Number (ASN)"
  type        = string
}
variable "google_interconnect_name" {
  description = "The Google Interconnect Name"
  type        = string
}
variable "google_interconnect_type" {
  description = "The Google Interconnect Type"
  type        = string
}
variable "google_interconnect_edge_availability_domain" {
  description = "The Google Interconnect Edge Availability Domain"
  type        = string
}
#Fabric Connection
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
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
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "project_id" {
  description = "Equinix Fabric Project Id"
  type        = string
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
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
```

outputs.tf
```hcl
output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "GCP_Network_Id" {
  value = google_compute_network.metal-nimf-google.id
}
output "GCP_Router_Id" {
  value = google_compute_router.metal-nimf-google.id
}
output "GCP_Interconnect_Id" {
  value = google_compute_interconnect_attachment.metal-nimf-google.id
}
output "Metal_Google_Connection_Id" {
  value = module.metal_2_google_connection.primary_connection_id
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
provider "google" {
  region      = var.google_region
  project     = var.google_project_id
  zone        = var.google_zone
  credentials = var.google_credentials_path
}

resource "equinix_metal_vlan" "vlan-server" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = var.metal_connection_metro
  project_id  = var.metal_project_id
}

resource "equinix_metal_connection" "metal-connection" {
  name          = var.metal_connection_name
  redundancy    = var.metal_connection_redundancy
  speed         = var.metal_connection_speed
  type          = var.metal_connection_type
  project_id    = var.metal_project_id
  metro         = var.metal_connection_metro
  vlans         = [equinix_metal_vlan.vlan-server.vxlan]
  contact_email = var.metal_contact_email
}

resource "google_compute_network" "metal-nimf-google" {
  project                 = var.google_project_id
  name                    = var.google_network_name
  mtu                     = var.google_network_mtu
  auto_create_subnetworks = var.google_network_auto_create_subnetwork
}

resource "google_compute_router" "metal-nimf-google" {
  name    = var.google_router_name
  network = google_compute_network.metal-nimf-google.name
  bgp {
    asn = var.google_router_bgp_asn
  }
}

resource "google_compute_interconnect_attachment" "metal-nimf-google" {
  name                     = var.google_interconnect_name
  type                     = var.google_interconnect_type
  router                   = google_compute_router.metal-nimf-google.id
  region                   = var.google_region
  edge_availability_domain = var.google_interconnect_edge_availability_domain
}

module "metal_2_google_connection" {
  source = "equinix/fabric/equinix//modules/metal-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = google_compute_interconnect_attachment.metal-nimf-google.pairing_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.google_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}

resource "time_sleep" "wait_dl_connection" {
  depends_on      = [module.metal_2_google_connection]
  create_duration = "2m"
}

data "equinix_metal_connection" "NIMF-test" {
  depends_on    = [time_sleep.wait_dl_connection]
  connection_id = equinix_metal_connection.metal-connection.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.34.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 5.17.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal_2_google_connection"></a> [metal\_2\_google\_connection](#module\_metal\_2\_google\_connection) | equinix/fabric/equinix//modules/metal-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [google_compute_interconnect_attachment.metal-nimf-google](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/compute_interconnect_attachment) | resource |
| [google_compute_network.metal-nimf-google](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/compute_network) | resource |
| [google_compute_router.metal-nimf-google](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/compute_router) | resource |
| [time_sleep.wait_dl_connection](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [equinix_metal_connection.NIMF-test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_google_credentials_path"></a> [google\_credentials\_path](#input\_google\_credentials\_path) | Path to the contents of a service account key file in JSON format | `string` | n/a | yes |
| <a name="input_google_interconnect_edge_availability_domain"></a> [google\_interconnect\_edge\_availability\_domain](#input\_google\_interconnect\_edge\_availability\_domain) | The Google Interconnect Edge Availability Domain | `string` | n/a | yes |
| <a name="input_google_interconnect_name"></a> [google\_interconnect\_name](#input\_google\_interconnect\_name) | The Google Interconnect Name | `string` | n/a | yes |
| <a name="input_google_interconnect_type"></a> [google\_interconnect\_type](#input\_google\_interconnect\_type) | The Google Interconnect Type | `string` | n/a | yes |
| <a name="input_google_network_auto_create_subnetwork"></a> [google\_network\_auto\_create\_subnetwork](#input\_google\_network\_auto\_create\_subnetwork) | When set to true, the network is created in auto subnet mode | `bool` | n/a | yes |
| <a name="input_google_network_mtu"></a> [google\_network\_mtu](#input\_google\_network\_mtu) | The Google Network Maximum Transmission Unit in bytes | `string` | n/a | yes |
| <a name="input_google_network_name"></a> [google\_network\_name](#input\_google\_network\_name) | The Google Network Name | `string` | n/a | yes |
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | The default Google Project Id to manage resources in | `string` | n/a | yes |
| <a name="input_google_region"></a> [google\_region](#input\_google\_region) | The Google region to manage resources in | `string` | n/a | yes |
| <a name="input_google_router_bgp_asn"></a> [google\_router\_bgp\_asn](#input\_google\_router\_bgp\_asn) | The Google Router Local BGP Autonomous System Number (ASN) | `string` | n/a | yes |
| <a name="input_google_router_name"></a> [google\_router\_name](#input\_google\_router\_name) | The Google Router Name | `string` | n/a | yes |
| <a name="input_google_zone"></a> [google\_zone](#input\_google\_zone) | The default Google Zone to manage resources in | `string` | n/a | yes |
| <a name="input_metal_auth_token"></a> [metal\_auth\_token](#input\_metal\_auth\_token) | Equinix Metal Authentication API Token | `string` | n/a | yes |
| <a name="input_metal_connection_metro"></a> [metal\_connection\_metro](#input\_metal\_connection\_metro) | Metro where the connection will be created | `string` | n/a | yes |
| <a name="input_metal_connection_name"></a> [metal\_connection\_name](#input\_metal\_connection\_name) | Metal Connection Name | `string` | n/a | yes |
| <a name="input_metal_connection_redundancy"></a> [metal\_connection\_redundancy](#input\_metal\_connection\_redundancy) | Metal Connection redundancy - redundant or primary | `string` | n/a | yes |
| <a name="input_metal_connection_speed"></a> [metal\_connection\_speed](#input\_metal\_connection\_speed) | Metal Connection speed - one of 50Mbps, 200Mbps, 500Mbps, 1Gbps, 2Gbps, 5Gbps, 10Gbps | `string` | n/a | yes |
| <a name="input_metal_connection_type"></a> [metal\_connection\_type](#input\_metal\_connection\_type) | Metal Connection type - dedicated , shared or shared\_port\_vlan | `string` | n/a | yes |
| <a name="input_metal_contact_email"></a> [metal\_contact\_email](#input\_metal\_contact\_email) | Preferred email used for communication | `string` | n/a | yes |
| <a name="input_metal_project_id"></a> [metal\_project\_id](#input\_metal\_project\_id) | Metal Project Name | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Equinix Fabric Project Id | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_GCP_Interconnect_Id"></a> [GCP\_Interconnect\_Id](#output\_GCP\_Interconnect\_Id) | n/a |
| <a name="output_GCP_Network_Id"></a> [GCP\_Network\_Id](#output\_GCP\_Network\_Id) | n/a |
| <a name="output_GCP_Router_Id"></a> [GCP\_Router\_Id](#output\_GCP\_Router\_Id) | n/a |
| <a name="output_Metal_Google_Connection_Id"></a> [Metal\_Google\_Connection\_Id](#output\_Metal\_Google\_Connection\_Id) | n/a |
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_connection_status"></a> [metal\_connection\_status](#output\_metal\_connection\_status) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
<!-- END_TF_DOCS -->
