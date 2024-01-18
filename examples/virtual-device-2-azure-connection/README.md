# Fabric Virtual Device to Fabric Azure Service Profile Connection

This example shows how to leverage the [Fabric Virtual Device Connection Module](../../modules/virtual-device-connection/README.md)
to create a Fabric Connection from a Fabric Virtual Device to Fabric Azure Service Profile.

It leverages the Equinix Terraform Provider, the Azure Terraform Provider, and the Fabric Virtual Device Connection
Module to setup the connection based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

See example usage below for details on how to use this example.

<!-- Begin Example Usage (Do not edit contents) -->
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
equinix_endpoint       = "endpointURL"

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
secondary_connection_name   = "VD2Azure Sec"
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
versions.tf:
```hcl

terraform {
  required_version = ">= 1.5.2"
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
variables.tf:
```hcl

variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
}
variable "equinix_endpoint" {
  description = "Equinix endpoint URL"
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
  type = string
}
variable "network_public_key" {
  description = "The SSH public key"
  type        = string
}
#Azure Provider
variable "azure_client_id" {
  description = "Azure Client id"
  type        = string
}
variable "azure_client_secret" {
  description = "Azure Secret value"
  type        = string
}
variable "azure_tenant_id" {
  description = "Azure Tenant id"
  type        = string
}
variable "azure_subscription_id" {
  description = "Azure Subscription id"
  type        = string
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
variable "secondary_connection_name" {
  description = "Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
  default     = ""
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
outputs.tf:
```hcl

output "virtual_device_id" {
  value = equinix_network_device.C8KV-SV.id
}
output "azure_connection_id" {
  value = module.create_virtual_device_2_azure_connection.primary_connection_id
}
```
main.tf:
```hcl

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  endpoint      = var.equinix_endpoint
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

resource "equinix_network_ssh_key" "suneeth-ssh" {
  name       = var.network_public_key_name
  public_key = var.network_public_key
}

#Azure Provider
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

#Connection
module "create_virtual_device_2_azure_connection" {
  source = "equinix/fabric/equinix//modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.port2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = equinix_network_device.C8KV-SV.id

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_peering_type          = var.zside_peering_type
  zside_ap_authentication_key = azurerm_express_route_circuit.port2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_sp_name               = var.zside_sp_name
}
```
<!-- End Example Usage -->
