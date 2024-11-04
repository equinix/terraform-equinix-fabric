# Fabric Virtual Device to Fabric Azure Service Profile Connection

This example shows how to leverage the [Fabric Virtual Device Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/virtual-device-connection)
to create a Fabric Connection from a Fabric Virtual Device to Fabric Azure Service Profile.

It leverages the Equinix Terraform Provider, the Azure Terraform Provider, and the Fabric Virtual Device Connection
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
cd terraform-equinix-fabric/examples/virtual-device-2-azure-connection
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

#network_ssh_key
network_public_key_name = "<Public_SSH_Key_Name>"
network_public_key      = "<Public_SSH_Key>"

#Azure Provider
azure_client_id             = "<Azure Client Id>"
azure_client_secret         = "<Azure Client Secret Value>"
azure_tenant_id             = "<Azure Tenant Id>"
azure_subscription_id       = "<Azure Subscription Id>"
azure_resource_name         = "Azure-Test"
azure_location              = "West US 2"

azure_service_key_name      = "Test_Azure_Key"
azure_service_provider_name = "<Service Provider Name>"
azure_peering_location      = "Silicon Valley Test"
azure_tier                  = "Standard"
azure_family                = "UnlimitedData"
azure_environment           = "UAT"

#VD_2_Azure_Connection
connection_name             = "VD2Azure"
connection_type             = "EVPL_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
purchase_order_number       = "1-323292"

aside_vd_type               = "EDGE"
zside_ap_type               = "SP"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_sp_name               = "Azure ExpressRoute"
zside_peering_type          = "PRIVATE"
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
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.84.0"
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
variable "network_public_key_name" {
  description = "The name of SSH key used for identification."
  type        = string
}
variable "network_public_key" {
  description = "The SSH public key"
  type        = string
  sensitive   = true
}
#Azure Provider
variable "azure_client_id" {
  description = "Azure Client id"
  type        = string
  sensitive   = true
}
variable "azure_client_secret" {
  description = "Azure Secret value"
  type        = string
  sensitive   = true
}
variable "azure_tenant_id" {
  description = "Azure Tenant id"
  type        = string
  sensitive   = true
}
variable "azure_subscription_id" {
  description = "Azure Subscription id"
  type        = string
  sensitive   = true
}
variable "azure_resource_name" {
  description = "The name of Azure Resource"
  type        = string
}
variable "azure_location" {
  description = "The location of Azure service provider(resource)"
  type        = string
}
variable "azure_service_key_name" {
  description = "Azure Service Key Name"
  type        = string
}
variable "azure_service_provider_name" {
  description = "The name of Azure Service Provider"
  type        = string
  default     = ""
}
variable "azure_peering_location" {
  description = "The name of the peering location (not the Azure resource location)"
  type        = string
  default     = ""
}
variable "azure_tier" {
  description = "The Service tier. Possible values are Basic, Local, Standard or Premium"
  type        = string
}
variable "azure_family" {
  description = "The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData"
  type        = string
}
variable "azure_environment" {
  description = "The Cloud environment which should be used for Service Key"
  type        = string
}
#Connection Variables
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
  default     = 50
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
  default     = ""
}
variable "aside_vd_uuid" {
  description = "Virtual Device UUID"
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
variable "zside_peering_type" {
  description = "Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  type        = string
}
```

outputs.tf
```hcl
output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "azure_connection" {
  value = module.create_virtual_device_2_azure_connection.primary_connection
  sensitive = true
}

output "azure_connection_id" {
  value = module.create_virtual_device_2_azure_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id

  skip_provider_registration = true
}

#Network Edge Module
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
  name            = var.ne_name
  metro_code      = var.ne_metro_code
  type_code       = var.ne_type_code
  self_managed    = true
  byol            = true
  package_code    = var.ne_package_code
  notifications   = var.ne_notifications
  hostname        = var.ne_hostname
  account_number  = var.ne_account_number
  version         = var.ne_version
  core_count      = var.ne_core_count
  term_length     = var.ne_term_length

  ssh_key {
    username = var.ne_ssh_key_username
    key_name = var.ne_ssh_key_name
  }
  acl_template_id = equinix_network_acl_template.wan-acl-template.id
}

#Azure Provider
resource "azurerm_resource_group" "vd2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "vd2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.vd2azure.name
  location              = azurerm_resource_group.vd2azure.location
  service_provider_name = var.azure_service_provider_name
  peering_location      = var.azure_peering_location
  bandwidth_in_mbps     = var.bandwidth
  sku {
    tier   = var.azure_tier
    family = var.azure_family
  }
  allow_classic_operations = false
  tags = {
    environment = var.azure_environment
  }
}

#Connection
module "create_virtual_device_2_azure_connection" {
  source = "equinix/fabric/equinix//modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.vd2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = equinix_network_device.C8KV-SV.id

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_peering_type          = var.zside_peering_type
  zside_ap_authentication_key = azurerm_express_route_circuit.vd2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_sp_name               = var.zside_sp_name
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.84.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.84.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_virtual_device_2_azure_connection"></a> [create\_virtual\_device\_2\_azure\_connection](#module\_create\_virtual\_device\_2\_azure\_connection) | equinix/fabric/equinix//modules/virtual-device-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.vd2azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit) | resource |
| [azurerm_resource_group.vd2azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [equinix_network_acl_template.wan-acl-template](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_acl_template) | resource |
| [equinix_network_device.C8KV-SV](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_vd_type"></a> [aside\_vd\_type](#input\_aside\_vd\_type) | Virtual Device type - EDGE | `string` | `""` | no |
| <a name="input_aside_vd_uuid"></a> [aside\_vd\_uuid](#input\_aside\_vd\_uuid) | Virtual Device UUID | `string` | `""` | no |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Azure Client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Azure Secret value | `string` | n/a | yes |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Cloud environment which should be used for Service Key | `string` | n/a | yes |
| <a name="input_azure_family"></a> [azure\_family](#input\_azure\_family) | The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | The location of Azure service provider(resource) | `string` | n/a | yes |
| <a name="input_azure_peering_location"></a> [azure\_peering\_location](#input\_azure\_peering\_location) | The name of the peering location (not the Azure resource location) | `string` | `""` | no |
| <a name="input_azure_resource_name"></a> [azure\_resource\_name](#input\_azure\_resource\_name) | The name of Azure Resource | `string` | n/a | yes |
| <a name="input_azure_service_key_name"></a> [azure\_service\_key\_name](#input\_azure\_service\_key\_name) | Azure Service Key Name | `string` | n/a | yes |
| <a name="input_azure_service_provider_name"></a> [azure\_service\_provider\_name](#input\_azure\_service\_provider\_name) | The name of Azure Service Provider | `string` | `""` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant id | `string` | n/a | yes |
| <a name="input_azure_tier"></a> [azure\_tier](#input\_azure\_tier) | The Service tier. Possible values are Basic, Local, Standard or Premium | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | `50` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
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
| <a name="input_network_public_key"></a> [network\_public\_key](#input\_network\_public\_key) | The SSH public key | `string` | n/a | yes |
| <a name="input_network_public_key_name"></a> [network\_public\_key\_name](#input\_network\_public\_key\_name) | The name of SSH key used for identification. | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | ACL Template description | `string` | n/a | yes |
| <a name="input_template_dst_port"></a> [template\_dst\_port](#input\_template\_dst\_port) | Inbound traffic destination ports | `string` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | ACL Template Name | `string` | n/a | yes |
| <a name="input_template_protocol"></a> [template\_protocol](#input\_template\_protocol) | Inbound traffic protocol | `string` | n/a | yes |
| <a name="input_template_src_port"></a> [template\_src\_port](#input\_template\_src\_port) | Inbound traffic source ports | `string` | n/a | yes |
| <a name="input_template_subnet"></a> [template\_subnet](#input\_template\_subnet) | Inbound traffic source IP subnets in CIDR format | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_connection"></a> [azure\_connection](#output\_azure\_connection) | n/a |
| <a name="output_azure_connection_id"></a> [azure\_connection\_id](#output\_azure\_connection\_id) | n/a |
| <a name="output_virtual_device_id"></a> [virtual\_device\_id](#output\_virtual\_device\_id) | n/a |
<!-- END_TF_DOCS -->
