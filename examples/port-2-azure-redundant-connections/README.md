# Fabric Port to Fabric Azure Service Profile Redundant Connection

This example shows how to leverage the [Fabric Port Connection Module](equinix/fabric/modules/port-connection/README.md)
to create a Fabric Connection from a Fabric Port to Fabric Azure Service Profile with two connections. A primary
and secondary connection.

It leverages the Equinix Terraform Provider, the Azure Terraform Provider, and the Fabric Port Connection
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
cd terraform-equinix-fabric/examples/port-2-azure-redundant-connections
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

connection_name             = "Port2Azure"
secondary_connection_name   = "Port2Azure_2ndary"
connection_type             = "EVPL_VC"
notifications_type          = "ALL"
notifications_emails        = ["example@equinix.com"]
bandwidth                   = 100
secondary_bandwidth         = 100
purchase_order_number       = "1-323292"
aside_port_name             = "200001-SV1-CX-Primary-01"
aside_secondary_port_name   = "200001-SV5-CX-Secondary-02"
aside_vlan_tag              = "2867"
aside_vlan_inner_tag        = "2098"
zside_ap_type               = "SP"
zside_ap_authentication_key = "<Azure Express Route Service Key>"
zside_ap_profile_type       = "L2_PROFILE"
zside_location              = "SV"
zside_sp_name               = "Azure ExpressRoute"
zside_peering_type          = "PRIVATE"
azure_client_id             = "<Azure Client Id>"
azure_client_secret         = "<Azure Client Secret Value>"
azure_tenant_id             = "<Azure Tenant Id>"
azure_subscription_id       = "<Azure Subscription Id>"
azure_resource_name             = "Azure Test"
azure_location              = "West US 2"
azure_service_key_name      = "Test_Azure_Key"
azure_service_provider_name = "<Service Provider Name>"
azure_peering_location      = "Silicon Valley Test"
azure_tier                  = "Standard"
azure_family                = "UnlimitedData"
azure_environment           = "PROD"
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
variable "secondary_connection_name" {
  description = "Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
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
variable "secondary_bandwidth" {
  description = "Secondary Connection bandwidth in Mbps"
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
variable "aside_secondary_port_name" {
  description = "Secondary Equinix A-Side Port Name"
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
variable "zside_peering_type" {
  description = "Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  type        = string
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
  description = "The location of Azure service provider(resource)"
  type        = string
}
variable "azure_service_key_name" {
  description = "Azure Service Key"
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
}

```

outputs.tf
```hcl
output "azure_primary_connection_id" {
  value = module.create_port_2_azure_connections.primary_connection_id
}

output "azure_secondary_connection_id" {
  value = module.create_port_2_azure_connections.secondary_connection_id
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
resource "azurerm_resource_group" "port2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "port2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.port2azure.name
  location              = azurerm_resource_group.port2azure.location
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
module "create_port_2_azure_connections" {
  source = "equinix/fabric/equinix//modules/port-connection"

  # Primary Connection
  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.port2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  # Secondary Connection Overrides
  secondary_connection_name = var.secondary_connection_name
  secondary_bandwidth       = azurerm_express_route_circuit.port2azure.bandwidth_in_mbps

  # Primary A-side
  aside_port_name      = var.aside_port_name
  aside_vlan_tag       = var.aside_vlan_tag
  aside_vlan_inner_tag = var.aside_vlan_inner_tag

  # Secondary A-side
  aside_secondary_port_name = var.aside_secondary_port_name

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = azurerm_express_route_circuit.port2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_sp_name               = var.zside_sp_name
  zside_peering_type          = var.zside_peering_type
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
| <a name="module_create_port_2_azure_connections"></a> [create\_port\_2\_azure\_connections](#module\_create\_port\_2\_azure\_connections) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.port2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/express_route_circuit) | resource |
| [azurerm_resource_group.port2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_secondary_port_name"></a> [aside\_secondary\_port\_name](#input\_aside\_secondary\_port\_name) | Secondary Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_aside_vlan_inner_tag"></a> [aside\_vlan\_inner\_tag](#input\_aside\_vlan\_inner\_tag) | Vlan Inner Tag information, inner vlanCTag for QINQ connections | `string` | `""` | no |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Azure Client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Azure Secret value | `string` | n/a | yes |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Cloud environment which should be used for Service Key | `any` | n/a | yes |
| <a name="input_azure_family"></a> [azure\_family](#input\_azure\_family) | The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | The location of Azure service provider(resource) | `string` | n/a | yes |
| <a name="input_azure_peering_location"></a> [azure\_peering\_location](#input\_azure\_peering\_location) | The name of the peering location (not the Azure resource location) | `string` | `""` | no |
| <a name="input_azure_resource_name"></a> [azure\_resource\_name](#input\_azure\_resource\_name) | The name of Azure Resource | `string` | n/a | yes |
| <a name="input_azure_service_key_name"></a> [azure\_service\_key\_name](#input\_azure\_service\_key\_name) | Azure Service Key | `string` | n/a | yes |
| <a name="input_azure_service_provider_name"></a> [azure\_service\_provider\_name](#input\_azure\_service\_provider\_name) | The name of Azure Service Provider | `string` | `""` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant id | `string` | n/a | yes |
| <a name="input_azure_tier"></a> [azure\_tier](#input\_azure\_tier) | The Service tier. Possible values are Basic, Local, Standard or Premium | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Secondary Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_primary_connection_id"></a> [azure\_primary\_connection\_id](#output\_azure\_primary\_connection\_id) | n/a |
| <a name="output_azure_secondary_connection_id"></a> [azure\_secondary\_connection\_id](#output\_azure\_secondary\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
