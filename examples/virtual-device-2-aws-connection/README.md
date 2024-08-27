# Fabric Virtual Device to Fabric AWS Service Profile Connection

This example shows how to leverage the [Fabric Virtual Device Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/virtual-device-connection)
to create a Fabric Connection from a Fabric Virtual Device to Fabric AWS Service Profile.

It leverages the Equinix Terraform Provider, the AWS Terraform Provider, and the Fabric Virtual Device Connection
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
cd terraform-equinix-fabric/examples/virtual-device-2-aws-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

#NE Acl Template
template_name           = "test-wan-acl-template"
template_description    = "WAN ACL template"
template_subnet         = "172.16.25.0/24"
template_protocol       = "TCP"
template_src_port       = "any"
template_dst_port       = "22"

#Network Edge
ne_name                 = "Terra_Test_router"
ne_metro_code           = "SV"
ne_type_code            = "C8000V"
ne_package_code         = "network-essentials"
ne_notifications        = ["test@eq.com"]
ne_hostname             = "C8KV"
ne_account_number       = "182390403"
ne_version              = "17.11.01a"
ne_core_count           = 2
ne_term_length          = 1

ne_ssh_key_username     = "<SSH_Key_Username>"
ne_ssh_key_name         = "<SSH_Key_Name"

#VD_2_AWS_Connection
aside_vd_type               = "EDGE"
aside_vd_uuid               = "<Virtual Device UUID>"
zside_ap_type               = "SP"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_sp_name               = "AWS"
zside_peering_type          = "PRIVATE"

notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com","test1@equinix.com"]
purchase_order_number       = "1-323292"
connection_name             = "VD_2_AWS"
connection_type             = "EVPL_VC"
bandwidth                   = 50
zside_ap_type               = "SP"
zside_ap_authentication_key = "<AWS Account Id>"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_seller_region         = "us-west-1"
zside_fabric_sp_name        = "AWS Direct Connect"
additional_info             = [
  {
    key   = "accessKey"
    value = "<aws_access_key>"
  },
  {
    key   = "secretKey"
    value = "<aws_secret_key>"
  }
]

#AWS Provider
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
      version = ">= 1.20.0"
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
variable "aside_vd_uuid" {
  description = "Equinix-assigned Virtual Device identifier"
  type        = string
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  sensitive   = true
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
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
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
  type        = string
  default     = ""
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
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
#Network Edge
variable "ne_name" {
  description = "Device Name"
  type        = string
}
variable "ne_metro_code" {
  description = "Device location metro code"
  type        = string
}
variable "ne_type_code" {
  description = ""
  type        = string
}
variable "ne_package_code" {
  description = "Device software package code"
  type        = string
}
variable "ne_notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
}
variable "ne_hostname" {
  description = "Device hostname prefix"
  type        = string
}
variable "ne_account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}
variable "ne_version" {
  description = "Device software version"
  type        = string
  default     = null
}
variable "ne_core_count" {
  description = "Core count number"
  type        = number
}
variable "ne_term_length" {
  description = "Term length in months"
  type        = number
}
variable "ne_ssh_key_username" {
  description = "username for ssh key"
  type        = string
}
variable "ne_ssh_key_name" {
  description = "ssh key name for device"
  type        = string
}
##NE Acl Template
variable "template_name" {
  description = "ACL Template Name"
  type        = string
}
variable "template_description" {
  description = "ACL Template description"
  type        = string
}
variable "template_subnet" {
  description = "Inbound traffic source IP subnets in CIDR format"
  type        = string
}
variable "template_protocol" {
  description = "Inbound traffic protocol"
  type        = string
}
variable "template_src_port" {
  description = "Inbound traffic source ports"
  type        = string
}
variable "template_dst_port" {
  description = "Inbound traffic destination ports"
  type        = string
}
```

outputs.tf
```hcl
output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "aws_connection_id" {
  value = module.virtual_device_2_aws_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

provider "aws" {
  access_key = var.additional_info[0]["value"]
  secret_key = var.additional_info[1]["value"]
  region     = var.zside_seller_region
}

## Creates NE ACL template and assigns it to the network device
resource "equinix_network_acl_template" "wan-acl-template" {
  name        = var.template_name
  description = var.template_description
  inbound_rule {
    subnet   = var.template_subnet
    protocol = var.template_protocol
    src_port = var.template_src_port
    dst_port = var.template_dst_port
  }
}

resource "equinix_network_device" "C8KV-SV" {
  name           = var.ne_name
  metro_code     = var.ne_metro_code
  type_code      = var.ne_type_code
  self_managed   = true
  byol           = true
  package_code   = var.ne_package_code
  notifications  = var.ne_notifications
  hostname       = var.ne_hostname
  account_number = var.ne_account_number
  version        = var.ne_version
  core_count     = var.ne_core_count
  term_length    = var.ne_term_length

  ssh_key {
    username = var.ne_ssh_key_username
    key_name = var.ne_ssh_key_name
  }
  acl_template_id = equinix_network_acl_template.wan-acl-template.id
}

#Connection
module "virtual_device_2_aws_connection" {
  source = "equinix/fabric/equinix//modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  additional_info       = var.additional_info
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = equinix_network_device.C8KV-SV.id

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = var.zside_ap_authentication_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_seller_region         = var.zside_seller_region
  zside_sp_name               = var.zside_sp_name
}

data "aws_dx_connection" "aws_connection" {
  depends_on = [
    module.virtual_device_2_aws_connection
  ]
  name = var.connection_name
}

resource "aws_dx_gateway" "aws_gateway" {
  depends_on = [
    module.virtual_device_2_aws_connection
  ]
  name            = var.aws_gateway_name
  amazon_side_asn = var.aws_gateway_asn
}

resource "aws_dx_private_virtual_interface" "aws_virtual_interface" {
  depends_on = [
    module.virtual_device_2_aws_connection,
    aws_dx_gateway.aws_gateway
  ]
  connection_id    = data.aws_dx_connection.aws_connection.id
  name             = var.aws_vif_name
  vlan             = data.aws_dx_connection.aws_connection.vlan_id
  address_family   = var.aws_vif_address_family
  bgp_asn          = var.aws_vif_bgp_asn
  amazon_address   = var.aws_vif_amazon_address
  customer_address = var.aws_vif_customer_address
  bgp_auth_key     = var.aws_vif_bgp_auth_key
  dx_gateway_id    = aws_dx_gateway.aws_gateway.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_virtual_device_2_aws_connection"></a> [virtual\_device\_2\_aws\_connection](#module\_virtual\_device\_2\_aws\_connection) | equinix/fabric/equinix//modules/virtual-device-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dx_gateway.aws_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_private_virtual_interface.aws_virtual_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [equinix_network_acl_template.wan-acl-template](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_acl_template) | resource |
| [equinix_network_device.C8KV-SV](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device) | resource |
| [aws_dx_connection.aws_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]` | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aside_vd_type"></a> [aside\_vd\_type](#input\_aside\_vd\_type) | Virtual Device type - EDGE | `string` | n/a | yes |
| <a name="input_aside_vd_uuid"></a> [aside\_vd\_uuid](#input\_aside\_vd\_uuid) | Equinix-assigned Virtual Device identifier | `string` | n/a | yes |
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
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_ne_account_number"></a> [ne\_account\_number](#input\_ne\_account\_number) | Billing account number for a device | `string` | `0` | no |
| <a name="input_ne_core_count"></a> [ne\_core\_count](#input\_ne\_core\_count) | Core count number | `number` | n/a | yes |
| <a name="input_ne_hostname"></a> [ne\_hostname](#input\_ne\_hostname) | Device hostname prefix | `string` | n/a | yes |
| <a name="input_ne_metro_code"></a> [ne\_metro\_code](#input\_ne\_metro\_code) | Device location metro code | `string` | n/a | yes |
| <a name="input_ne_name"></a> [ne\_name](#input\_ne\_name) | Device Name | `string` | n/a | yes |
| <a name="input_ne_notifications"></a> [ne\_notifications](#input\_ne\_notifications) | List of email addresses that will receive device status notifications | `list(string)` | n/a | yes |
| <a name="input_ne_package_code"></a> [ne\_package\_code](#input\_ne\_package\_code) | Device software package code | `string` | n/a | yes |
| <a name="input_ne_ssh_key_name"></a> [ne\_ssh\_key\_name](#input\_ne\_ssh\_key\_name) | ssh key name for device | `string` | n/a | yes |
| <a name="input_ne_ssh_key_username"></a> [ne\_ssh\_key\_username](#input\_ne\_ssh\_key\_username) | username for ssh key | `string` | n/a | yes |
| <a name="input_ne_term_length"></a> [ne\_term\_length](#input\_ne\_term\_length) | Term length in months | `number` | n/a | yes |
| <a name="input_ne_type_code"></a> [ne\_type\_code](#input\_ne\_type\_code) | n/a | `string` | n/a | yes |
| <a name="input_ne_version"></a> [ne\_version](#input\_ne\_version) | Device software version | `string` | `null` | no |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | ACL Template description | `string` | n/a | yes |
| <a name="input_template_dst_port"></a> [template\_dst\_port](#input\_template\_dst\_port) | Inbound traffic destination ports | `string` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | ACL Template Name | `string` | n/a | yes |
| <a name="input_template_protocol"></a> [template\_protocol](#input\_template\_protocol) | Inbound traffic protocol | `string` | n/a | yes |
| <a name="input_template_src_port"></a> [template\_src\_port](#input\_template\_src\_port) | Inbound traffic source ports | `string` | n/a | yes |
| <a name="input_template_subnet"></a> [template\_subnet](#input\_template\_subnet) | Inbound traffic source IP subnets in CIDR format | `string` | n/a | yes |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | `""` | no |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_connection_id"></a> [aws\_connection\_id](#output\_aws\_connection\_id) | n/a |
| <a name="output_virtual_device_id"></a> [virtual\_device\_id](#output\_virtual\_device\_id) | n/a |
<!-- END_TF_DOCS -->
