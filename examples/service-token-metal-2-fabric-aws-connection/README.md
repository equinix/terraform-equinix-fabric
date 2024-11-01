# Fabric Service Token - Equinix Metal to Fabric AWS Service Profile Connection

This example shows how to leverage the [Fabric Service Token Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/service-token-connection)
to create a Fabric Connection from Equinix Metal to Fabric AWS Service Profile.

It leverages the Equinix Terraform Provider, the AWS Terraform Provider, and the Fabric Service Token Connection
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
cd terraform-equinix-fabric/examples/service-token-metal-2-fabric-aws-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

metal_auth_token = "<Metal Auth API Token>"
metal_connection_speed_unit = "MB"
metal_connection_metro = "SV"
metal_project_id = "<Metal Project ID>"
metal_connection_description = "Connect from Equinix Metal to Service provider using a-side token"

connection_speed = 50
connection_name = "metal-2-fabric"
connection_type = "EVPL_VC"
notifications_type = "ALL"
notifications_emails = ["example@equinix.com"]
bandwidth = 50
purchase_order_number = "1-323292"
zside_ap_type = "SP"
zside_ap_authentication_key = "<AWS_ACCOUNT_ID>"
zside_ap_profile_type = "L2_PROFILE"
zside_location = "SV"
zside_sp_name = "AWS Direct Connect"
zside_seller_region = "us-west-1"
additional_info = [
  { key = "accessKey", value = "<aws_access_key>" },
  { key = "secretKey", value = "<aws_secret_key>" }
]

aws_gateway_name         = "aws_gateway"
aws_gateway_asn          = 64518
aws_vif_name             = "port2aws"
aws_vif_address_family   = "ipv4"
aws_vif_bgp_asn          = 64999
aws_vif_amazon_address   = "169.254.0.1/30"
aws_vif_customer_address = "169.254.0.2/30"
aws_vif_bgp_auth_key     = "secret"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.2"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.9.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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
variable "metal_connection_speed_unit" {
  description = "Unit of the speed/bandwidth to be allocated to the connection"
  type = string
  default = "MB"
}
variable "metal_connection_metro" {
  description = "Metro where the connection will be created"
  type        = string
}
variable "metal_project_id" {
  description = "Metal Project Name"
  type        = string
}
variable "metal_connection_description" {
  description = "Description for the connection resource"
  type        = string
  default     =  "Connect from Equinix Metal to Service provider using a-side token"
}
variable "connection_speed" {
  description = "Speed/Bandwidth to be allocated to the connection - (MB or GB)"
  type        = number
  default     = 50
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
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = ""
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
  default     = ""
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
variable "aws_gateway_name" {
  description = "The name of the Gateway"
  type        = string
}
variable "aws_gateway_asn" {
  description = "The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294"
  type        = number
}
variable "aws_vif_name" {
  description = "The name for the virtual interface"
  type        = string
}
variable "aws_vif_address_family" {
  description = "The address family for the BGP peer. ipv4 or ipv6"
  type        = string
}
variable "aws_vif_bgp_asn" {
  description = "The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration"
  type        = number
}
variable "aws_vif_amazon_address" {
  description = "The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_customer_address" {
  description = "The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_bgp_auth_key" {
  description = "The authentication key for BGP configuration"
  type        =  string
  default     = ""
  sensitive   = true
}
```

outputs.tf
```hcl
output "metal-connection" {
  value = equinix_metal_connection.metal-connection.id
}
output "fabric-connection" {
  value = module.metal-2-fabric-connection.primary_connection
}
output "aws_dx_gateway_id" {
  value = aws_dx_gateway.aws_gateway.id
}
output "aws_interface_id" {
  value = aws_dx_private_virtual_interface.aws_virtual_interface.id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  auth_token    = var.metal_auth_token
}
provider "aws" {
  access_key = var.additional_info[0]["value"]
  secret_key = var.additional_info[1]["value"]
  region     = var.zside_seller_region
}
resource "random_string" "random" {
  length  = 3
  special = false
}
locals {
  connection_name  = format("%s-%s", var.connection_name, random_string.random.result)
  metal_speed_unit = var.metal_connection_speed_unit == "GB" ? "Gbps" : "Mbps"
}
resource "equinix_metal_device" "s1" {
  hostname         = "tf-rocky9-server-${var.metal_connection_metro}-1"
  plan             = "m3.small.x86"
  metro            = lower(var.metal_connection_metro)
  operating_system = "rocky_9"
  billing_cycle    = "hourly"
  project_id       = var.metal_project_id
}
resource "equinix_metal_vlan" "vlan-server-1" {
  description = "${var.metal_connection_metro} VLAN Server 1 to Cloud"
  metro       = lower(var.metal_connection_metro)
  project_id  = var.metal_project_id
}
resource "equinix_metal_device_network_type" "s1-network-type" {
  device_id = equinix_metal_device.s1.id
  type      = "hybrid"
}
resource "equinix_metal_port_vlan_attachment" "s1-attachment" {
  device_id = equinix_metal_device_network_type.s1-network-type.id
  port_name = "bond0"
  vlan_vnid = equinix_metal_vlan.vlan-server-1.vxlan
}
resource "equinix_metal_connection" "metal-connection" {
  name               = local.connection_name
  project_id         = var.metal_project_id
  metro              = var.metal_connection_metro
  redundancy         = "primary"
  type               = "shared"
  service_token_type = "a_side"
  description        = var.metal_connection_description
  tags               = ["terraform"]
  speed              = format("%d%s", var.connection_speed, local.metal_speed_unit)
  vlans              = [equinix_metal_vlan.vlan-server-1.vxlan] // required for shared connection
  contact_email      = "srpatel@equinix.com"
}
module "metal-2-fabric-connection" {
  source = "equinix/fabric/equinix//modules/service-token-connection"

  connection_name = var.connection_name
  connection_type = var.connection_type
  notifications_type = var.notifications_type
  notifications_emails = var.notifications_emails
  bandwidth = var.bandwidth
  purchase_order_number = var.purchase_order_number
  additional_info       = var.additional_info

  #A-Side
  aside_service_token_uuid = 	 equinix_metal_connection.metal-connection.service_tokens.0.id

  #Z-Side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_sp_name               = var.zside_sp_name
}
data "aws_dx_connection" "aws_connection" {
  depends_on = [
    module.metal-2-fabric-connection
  ]
  name = var.connection_name
}

resource "aws_dx_gateway" "aws_gateway" {
  depends_on = [
    module.metal-2-fabric-connection
  ]
  name            = var.aws_gateway_name
  amazon_side_asn = var.aws_gateway_asn
}

resource "aws_dx_private_virtual_interface" "aws_virtual_interface" {
  depends_on = [
    module.metal-2-fabric-connection,
    aws_dx_gateway.aws_gateway,
  ]
  connection_id    = data.aws_dx_connection.aws_connection.id
  name             = var.aws_vif_name
  vlan             = data.aws_dx_connection.aws_connection.vlan_id
  address_family   = var.aws_vif_address_family
  bgp_asn          = var.aws_vif_bgp_asn
  amazon_address   = var.aws_vif_amazon_address
  customer_address = var.aws_vif_customer_address
  bgp_auth_key     = var.aws_vif_bgp_auth_key
  dx_gateway_id   = aws_dx_gateway.aws_gateway.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.9.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal-2-fabric-connection"></a> [metal-2-fabric-connection](#module\_metal-2-fabric-connection) | equinix/fabric/equinix//modules/service-token-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dx_gateway.aws_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_private_virtual_interface.aws_virtual_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_device.s1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_device) | resource |
| [equinix_metal_device_network_type.s1-network-type](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_device_network_type) | resource |
| [equinix_metal_port_vlan_attachment.s1-attachment](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_port_vlan_attachment) | resource |
| [equinix_metal_vlan.vlan-server-1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_dx_connection.aws_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values. | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aws_gateway_asn"></a> [aws\_gateway\_asn](#input\_aws\_gateway\_asn) | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294 | `number` | n/a | yes |
| <a name="input_aws_gateway_name"></a> [aws\_gateway\_name](#input\_aws\_gateway\_name) | The name of the Gateway | `string` | n/a | yes |
| <a name="input_aws_vif_address_family"></a> [aws\_vif\_address\_family](#input\_aws\_vif\_address\_family) | The address family for the BGP peer. ipv4 or ipv6 | `string` | n/a | yes |
| <a name="input_aws_vif_amazon_address"></a> [aws\_vif\_amazon\_address](#input\_aws\_vif\_amazon\_address) | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_aws_vif_bgp_asn"></a> [aws\_vif\_bgp\_asn](#input\_aws\_vif\_bgp\_asn) | The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration | `number` | n/a | yes |
| <a name="input_aws_vif_bgp_auth_key"></a> [aws\_vif\_bgp\_auth\_key](#input\_aws\_vif\_bgp\_auth\_key) | The authentication key for BGP configuration | `string` | `""` | no |
| <a name="input_aws_vif_customer_address"></a> [aws\_vif\_customer\_address](#input\_aws\_vif\_customer\_address) | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_aws_vif_name"></a> [aws\_vif\_name](#input\_aws\_vif\_name) | The name for the virtual interface | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_speed"></a> [connection\_speed](#input\_connection\_speed) | Speed/Bandwidth to be allocated to the connection - (MB or GB) | `number` | `50` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_metal_auth_token"></a> [metal\_auth\_token](#input\_metal\_auth\_token) | Equinix Metal Authentication API Token | `string` | n/a | yes |
| <a name="input_metal_connection_description"></a> [metal\_connection\_description](#input\_metal\_connection\_description) | Description for the connection resource | `string` | `"Connect from Equinix Metal to Service provider using a-side token"` | no |
| <a name="input_metal_connection_metro"></a> [metal\_connection\_metro](#input\_metal\_connection\_metro) | Metro where the connection will be created | `string` | n/a | yes |
| <a name="input_metal_connection_speed_unit"></a> [metal\_connection\_speed\_unit](#input\_metal\_connection\_speed\_unit) | Unit of the speed/bandwidth to be allocated to the connection | `string` | `"MB"` | no |
| <a name="input_metal_project_id"></a> [metal\_project\_id](#input\_metal\_project\_id) | Metal Project Name | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `""` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_dx_gateway_id"></a> [aws\_dx\_gateway\_id](#output\_aws\_dx\_gateway\_id) | n/a |
| <a name="output_aws_interface_id"></a> [aws\_interface\_id](#output\_aws\_interface\_id) | n/a |
| <a name="output_fabric-connection"></a> [fabric-connection](#output\_fabric-connection) | n/a |
| <a name="output_metal-connection"></a> [metal-connection](#output\_metal-connection) | n/a |
<!-- END_TF_DOCS -->
