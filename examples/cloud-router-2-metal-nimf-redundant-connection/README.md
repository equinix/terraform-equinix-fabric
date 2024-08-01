# Fabric Cloud Router to Equinix Metal Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-connection)
to create a Fabric Connection from a Fabric Cloud Router to Equinix Metal.

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
cd terraform-equinix-fabric/examples/EXAMPLE_PATH
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
metal_connection_redundancy = "redundant"
metal_connection_speed      = "50Mbps"
metal_connection_type       = "shared_port_vlan"
metal_contact_email         = "tfacc@example.com"

connection_name                 = "FCR_2_Metal_DIGP"
connection_type                 = "IP_VC"
notifications_type              = "ALL"
notifications_emails            = ["example@equinix.com","test1@equinix.com"]
purchase_order_number           = "1-323292"
bandwidth                       = "50"
project_id                      = "<Fabric_Project_ID>"
zside_ap_type                   = "METAL_NETWORK"
primary_direct_rp_name          = "pri_direct_rp"
secondary_direct_rp_name        = "sec_direct_rp"
primary_direct_equinix_ipv4_ip  = "190.1.1.25/30"
secondary_direct_equinix_ipv4_ip = "190.1.1.9/30"
secondary_connection_name       = "fcr_2_metal_sec"
secondary_bandwidth             = "50"
aside_fcr_uuid                  = "<Primary Fabric Cloud router UUID>"


```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.36.4"
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
#Fabric Connection
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
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
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
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Primary Fabric Cloud Router identifier"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "secondary_connection_name" {
  description = "Secondary connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "secondary_bandwidth" {
  description = "Secondary connection bandwidth in Mbps"
  type        = number
}
variable "primary_direct_rp_name" {
  description = "Name of the Direct Routing Protocol"
  type        = string
}
variable "primary_direct_equinix_ipv4_ip" {
  description = "IPv4 Address for Direct Routing Protocol"
  type        = string
}
variable "secondary_direct_rp_name" {
  description = "Name of the Direct Routing Protocol for Secondary Connection"
  type        = string
}
variable "secondary_direct_equinix_ipv4_ip" {
  description = "IPv4 Address for Direct Routing Protocol for Secondary Connection"
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
output "cloud_router_metal_primary_connection_id" {
  value = module.cloud_router_2_metal_connection.primary_connection_id
}
output "primary_connection_cloud_router_routing_protocol_id" {
  value = module.primary_connection_routing_protocols.direct_routing_protocol_id
}
output "secondary_connection_cloud_router_routing_protocol_id" {
  value = module.secondary_connection_routing_protocols.direct_routing_protocol_id
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
resource "equinix_metal_vlan" "vlan-server" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = var.metal_connection_metro
  project_id  = var.metal_project_id
}
resource "equinix_metal_vlan" "vlan-server-1" {
  description = "${var.metal_connection_metro} VLAN Server 2 to Cloud"
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
  vlans         = [equinix_metal_vlan.vlan-server.vxlan, equinix_metal_vlan.vlan-server-1.vxlan]
  contact_email = var.metal_contact_email
}
module "cloud_router_2_metal_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  project_id            = var.project_id
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = equinix_metal_connection.metal-connection.authorization_code

  #Secondary-Connection
  secondary_connection_name = var.secondary_connection_name
  secondary_bandwidth       = var.secondary_bandwidth
}
module "primary_connection_routing_protocols" {
  depends_on = [module.cloud_router_2_metal_connection]
  source     = "../../modules/cloud-router-routing-protocols"

  connection_uuid = module.cloud_router_2_metal_connection.primary_connection_id

  # Direct RP Details
  direct_rp_name         = var.primary_direct_rp_name
  direct_equinix_ipv4_ip = var.primary_direct_equinix_ipv4_ip
}
module "secondary_connection_routing_protocols" {
  depends_on = [module.cloud_router_2_metal_connection]
  source     = "../../modules/cloud-router-routing-protocols"

  connection_uuid = module.cloud_router_2_metal_connection.secondary_connection_id

  # Direct RP Details
  direct_rp_name         = var.secondary_direct_rp_name
  direct_equinix_ipv4_ip = var.secondary_direct_equinix_ipv4_ip
}
resource "time_sleep" "wait_dl_connection" {
  depends_on = [
    module.primary_connection_routing_protocols,
    module.secondary_connection_routing_protocols
  ]
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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.36.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | 2.3.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_2_metal_connection"></a> [cloud\_router\_2\_metal\_connection](#module\_cloud\_router\_2\_metal\_connection) | ../../modules/cloud-router-connection | n/a |
| <a name="module_primary_connection_routing_protocols"></a> [primary\_connection\_routing\_protocols](#module\_primary\_connection\_routing\_protocols) | ../../modules/cloud-router-routing-protocols | n/a |
| <a name="module_secondary_connection_routing_protocols"></a> [secondary\_connection\_routing\_protocols](#module\_secondary\_connection\_routing\_protocols) | ../../modules/cloud-router-routing-protocols | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [equinix_metal_vlan.vlan-server-1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [time_sleep.wait_dl_connection](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [equinix_metal_connection.NIMF-test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Primary Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
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
| <a name="input_primary_direct_equinix_ipv4_ip"></a> [primary\_direct\_equinix\_ipv4\_ip](#input\_primary\_direct\_equinix\_ipv4\_ip) | IPv4 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_primary_direct_rp_name"></a> [primary\_direct\_rp\_name](#input\_primary\_direct\_rp\_name) | Name of the Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Equinix Fabric Project Id | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Secondary connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_secondary_direct_equinix_ipv4_ip"></a> [secondary\_direct\_equinix\_ipv4\_ip](#input\_secondary\_direct\_equinix\_ipv4\_ip) | IPv4 Address for Direct Routing Protocol for Secondary Connection | `string` | n/a | yes |
| <a name="input_secondary_direct_rp_name"></a> [secondary\_direct\_rp\_name](#input\_secondary\_direct\_rp\_name) | Name of the Direct Routing Protocol for Secondary Connection | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_router_metal_primary_connection_id"></a> [cloud\_router\_metal\_primary\_connection\_id](#output\_cloud\_router\_metal\_primary\_connection\_id) | n/a |
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_connection_status"></a> [metal\_connection\_status](#output\_metal\_connection\_status) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
| <a name="output_primary_connection_cloud_router_routing_protocol_id"></a> [primary\_connection\_cloud\_router\_routing\_protocol\_id](#output\_primary\_connection\_cloud\_router\_routing\_protocol\_id) | n/a |
| <a name="output_secondary_connection_cloud_router_routing_protocol_id"></a> [secondary\_connection\_cloud\_router\_routing\_protocol\_id](#output\_secondary\_connection\_cloud\_router\_routing\_protocol\_id) | n/a |
<!-- END_TF_DOCS -->

