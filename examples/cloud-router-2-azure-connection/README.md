# Fabric Cloud Router to Azure Service Profile Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-connection)
to create a Fabric Connection from a Fabric Cloud Router to Azure Service Profile.

It leverages the Equinix Terraform Provider, the Azure Terraform Provider, and the Fabric Cloud Router Connection
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
cd terraform-equinix-fabric/examples/examples/cloud-router-2-azure-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"

connection_name                 = "fcr_2_azure"
connection_type                 = "IP_VC"
notifications_type              = "ALL"
notifications_emails            = ["example@equinix.com","test1@equinix.com"]
purchase_order_number           = "1-323292"
bandwidth                       = 50
aside_fcr_uuid                  = "<Primary Fabric Cloud router UUID>"
zside_ap_type                   = "SP"
zside_ap_authentication_key     = "<Azure Service Key>"
zside_ap_profile_type           = "L2_PROFILE"
zside_location                  = "SV"
zside_peering_type              = "PRIVATE"
zside_fabric_sp_name            = "Azure ExpressRoute"
azure_client_id                 = "<Azure Client Id>"
azure_client_secret             = "<Azure Client Secret Value>"
azure_tenant_id                 = "<Azure Tenant Id>"
azure_subscription_id           = "<Azure Subscription Id>"
azure_resource_name             = "Azure Test"
azure_location                  = "West US 2"
azure_service_key_name          = "Test_Azure_Key"
azure_service_provider_name     = "<Service Provider Name>"
azure_peering_location          = "Silicon Valley Test"
azure_tier                      = "Standard"
azure_family                    = "UnlimitedData"
azure_environment               = "PROD"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.20.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.84.0"
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
  description = "The Location of Azure service provider(resource)"
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
```

outputs.tf
```hcl
output "azurerm_resource_group_id" {
  value = azurerm_resource_group.fcr2azure.id
}
output "azurerm_express_route_circuit" {
  value = azurerm_express_route_circuit.fcr2azure.id
}
output "azure_connection_id" {
  value = module.cloud_router_azure_connection.primary_connection_id
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
resource "azurerm_resource_group" "fcr2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "fcr2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.fcr2azure.name
  location              = azurerm_resource_group.fcr2azure.location
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
module "cloud_router_azure_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.fcr2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = azurerm_express_route_circuit.fcr2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_peering_type          = var.zside_peering_type
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.84.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_azure_connection"></a> [cloud\_router\_azure\_connection](#module\_cloud\_router\_azure\_connection) | equinix/fabric/equinix//modules/cloud-router-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.fcr2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/express_route_circuit) | resource |
| [azurerm_resource_group.fcr2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Azure Client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Azure Secret value | `string` | n/a | yes |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Cloud environment which should be used for Service Key | `string` | n/a | yes |
| <a name="input_azure_family"></a> [azure\_family](#input\_azure\_family) | The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | The Location of Azure service provider(resource) | `string` | n/a | yes |
| <a name="input_azure_peering_location"></a> [azure\_peering\_location](#input\_azure\_peering\_location) | The name of the peering location (not the Azure resource location) | `string` | `""` | no |
| <a name="input_azure_resource_name"></a> [azure\_resource\_name](#input\_azure\_resource\_name) | The name of Azure Resource | `string` | n/a | yes |
| <a name="input_azure_service_key_name"></a> [azure\_service\_key\_name](#input\_azure\_service\_key\_name) | Azure Service Key Name | `string` | n/a | yes |
| <a name="input_azure_service_provider_name"></a> [azure\_service\_provider\_name](#input\_azure\_service\_provider\_name) | The name of Azure Service Provider | `string` | `""` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant id | `string` | n/a | yes |
| <a name="input_azure_tier"></a> [azure\_tier](#input\_azure\_tier) | The Service tier. Possible values are Basic, Local, Standard or Premium | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `"PRIVATE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_connection_id"></a> [azure\_connection\_id](#output\_azure\_connection\_id) | n/a |
| <a name="output_azurerm_express_route_circuit"></a> [azurerm\_express\_route\_circuit](#output\_azurerm\_express\_route\_circuit) | n/a |
| <a name="output_azurerm_resource_group_id"></a> [azurerm\_resource\_group\_id](#output\_azurerm\_resource\_group\_id) | n/a |
<!-- END_TF_DOCS -->
