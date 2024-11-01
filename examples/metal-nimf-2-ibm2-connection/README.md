# Metal to IBM2 Service Profile Connection Example

This example shows how to leverage the [Metal Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/metal-connection)
to create a Fabric Connection from Equinix Metal to IBM2 Service Profile.

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
cd terraform-equinix-fabric/examples/metal-nimf-2-ibm2-connection
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

connection_name             = "Metal_2_IBM2"
connection_type             = "EVPL_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
bandwidth                   = 50
purchase_order_number       = "1-323292"
project_id                  = "<Project_ID>"
zside_ap_type               = "SP"
zside_ap_authentication_key = "<IBM2 Service Key>",
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_fabric_sp_name        = "IBM Cloud Direct Link 2"
zside_seller_region         = "San Jose 2"
additional_info             = [ {"key" : "ASN", "value": 1234 }]

ibm_cloud_api_key           = "<IBM_Cloud_API_Key",
ibm_classic_username        = "<IBM_Classic_Username>"
ibm_classic_api_key         = "<IBM_Classic_API_Key"
ibm_resource_group_name     = "Equinix"
ibm_gateway_action          = "create_gateway_approve"
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
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
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
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
}
variable "ibm_cloud_api_key" {
  description = "The IBM Cloud platform API key"
  type        = string
  sensitive   = true
}
variable "ibm_classic_username" {
  description = "The IBM Cloud Classic Infrastructure user name"
  type        = string
  sensitive   = true
}
variable "ibm_classic_api_key" {
  description = "The IBM Cloud Classic Infrastructure API key"
  type        = string
  sensitive   = true
}
variable "ibm_resource_group_name" {
  description = "The IBM Resource Group Name"
  type        = string
}
variable "ibm_gateway_action" {
  description = "IBM Approve/reject a pending change request"
  type        = string
}
variable "ibm_gateway_global" {
  description = "Required-Gateway with global routing as true can connect networks outside your associated region"
  type        = bool
  default     = true
}
variable "ibm_gateway_metered" {
  description = "Metered billing option. If set true gateway usage is billed per GB"
  type        = bool
  default     = true
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
output "Metal_IBM2_Connection" {
  value = module.metal_2_ibm2_connection.primary_connection
}
output "IBM_Gateway_Action_Id" {
  value = ibm_dl_gateway_action.test_dl_gateway_action.id
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

provider "ibm" {
  ibmcloud_api_key      = var.ibm_cloud_api_key
  iaas_classic_username = var.ibm_classic_username
  iaas_classic_api_key  = var.ibm_classic_api_key
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

module "metal_2_ibm2_connection" {
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
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_fabric_sp_name        = var.zside_fabric_sp_name
  additional_info             = var.additional_info
}

resource "time_sleep" "wait_dl_connection" {
  depends_on      = [module.metal_2_ibm2_connection]
  create_duration = "1m"
}

data "ibm_dl_gateway" "test_ibm_dl_gateway" {
  name       = var.connection_name
  depends_on = [time_sleep.wait_dl_connection]
}

data "ibm_resource_group" "rg" {
  name = var.ibm_resource_group_name
}

resource "ibm_dl_gateway_action" "test_dl_gateway_action" {
  gateway        = data.ibm_dl_gateway.test_ibm_dl_gateway.id
  action         = var.ibm_gateway_action
  global         = var.ibm_gateway_global
  metered        = var.ibm_gateway_metered
  resource_group = data.ibm_resource_group.rg.id
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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.9.0 |
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | >= 1.12.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal_2_ibm2_connection"></a> [metal\_2\_ibm2\_connection](#module\_metal\_2\_ibm2\_connection) | equinix/fabric/equinix//modules/metal-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [ibm_dl_gateway_action.test_dl_gateway_action](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/dl_gateway_action) | resource |
| [time_sleep.wait_dl_connection](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [equinix_metal_connection.NIMF-test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_connection) | data source |
| [ibm_dl_gateway.test_ibm_dl_gateway](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/dl_gateway) | data source |
| [ibm_resource_group.rg](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values. | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_ibm_classic_api_key"></a> [ibm\_classic\_api\_key](#input\_ibm\_classic\_api\_key) | The IBM Cloud Classic Infrastructure API key | `string` | n/a | yes |
| <a name="input_ibm_classic_username"></a> [ibm\_classic\_username](#input\_ibm\_classic\_username) | The IBM Cloud Classic Infrastructure user name | `string` | n/a | yes |
| <a name="input_ibm_cloud_api_key"></a> [ibm\_cloud\_api\_key](#input\_ibm\_cloud\_api\_key) | The IBM Cloud platform API key | `string` | n/a | yes |
| <a name="input_ibm_gateway_action"></a> [ibm\_gateway\_action](#input\_ibm\_gateway\_action) | IBM Approve/reject a pending change request | `string` | n/a | yes |
| <a name="input_ibm_gateway_global"></a> [ibm\_gateway\_global](#input\_ibm\_gateway\_global) | Required-Gateway with global routing as true can connect networks outside your associated region | `bool` | `true` | no |
| <a name="input_ibm_gateway_metered"></a> [ibm\_gateway\_metered](#input\_ibm\_gateway\_metered) | Metered billing option. If set true gateway usage is billed per GB | `bool` | `true` | no |
| <a name="input_ibm_resource_group_name"></a> [ibm\_resource\_group\_name](#input\_ibm\_resource\_group\_name) | The IBM Resource Group Name | `string` | n/a | yes |
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
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_IBM_Gateway_Action_Id"></a> [IBM\_Gateway\_Action\_Id](#output\_IBM\_Gateway\_Action\_Id) | n/a |
| <a name="output_Metal_IBM2_Connection"></a> [Metal\_IBM2\_Connection](#output\_Metal\_IBM2\_Connection) | n/a |
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_connection_status"></a> [metal\_connection\_status](#output\_metal\_connection\_status) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
<!-- END_TF_DOCS -->
