# Fabric Port to Fabric Public Service Profile Connection

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Public Service Profile.

It leverages the Equinix Terraform Provider, and the Fabric Port Connection
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
cd terraform-equinix-fabric/examples/port-ordering-port-2-public-service-profile-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

port_order_name          = "ExamplePortOrder"
port_order_metro_code    = "SV"
port_order_bandwidth     = 10000
encapsulation            = "DOT1Q"
purchase_order_number    = "PO-123456"
physical_ports_type      = "1000BASE_LX"
port_type                = "XF_PORT"
port_name                = "Test-Port"
physical_ports_speed     = 1000
connectivity_source_type = "COLO"
metro_code               = "SV"
ibx                      = "SV5"
demarcation_point_ibx    = "SV5"
tag_protocol_id          = "0x8150"
physical_port_id         = "1f4bc-6784c-7899ab"
cage_unique_space_id     = "SV5:04:118088"
cabinet_unique_space_id  = "Demarc"
patch_panel              = "PP:Demarc:11113088"
patch_panel_name         = "PP:Demarc:11113088"
patch_panel_portA        = "123"
patch_panel_portB        = "124"
project_id               = "1268h-989shk-898jk"
registered_user          = "testuser"

connection_name       = "Port2PublicSP"
connection_type       = "EVPL_VC"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com"]
bandwidth             = 50
purchase_order_number = "1-323292"
aside_port_name       = "sit-001-CX-SV1-NL-Dot1q-BO-10G-PRI-JP-34"
aside_vlan_tag        = "2019"
zside_ap_type         = "SP"
zside_ap_profile_type = "L2_PROFILE"
zside_location        = "SV"
zside_sp_name         = "AMCRH-Gen-SP"
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
variable "aside_port_uuid" {
 description = "Equinix A-Side Port UUID"
 type        = string
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
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
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "physical_ports_type" {
  description = "Physical ports type"
  type        = string
  default     = "1000BASE_LX"
}

variable "port_name" {
  description = "Port name"
  type        = string
  default     = "panthers-CX-SV5-NL-Dot1q-STD-1G-PRI-JP-170"
}

variable "physical_ports_speed" {
  description = "Physical ports speed"
  type        = number
  default     = 1000
}

variable "connectivity_source_type" {
  description = "Connectivity source type"
  type        = string
  default     = "COLO"
}
variable "account_number" {
  description = "Account number"
  type        = string
}
variable "org_id" {
  description = "Organization ID"
  type        = string
}
variable "metro_code" {
  description = "Metro code"
  type        = string
}
variable "ibx" {
  description = "IBX"
  type        = string
}
variable "demarcation_point_ibx" {
  description = "Demarcation point IBX"
  type        = string
}
variable "tag_protocol_id" {
  description = "Tag protocol ID"
  type        = string
}
variable "physical_port_id" {
  description = "Physical port ID"
  type        = string
}
variable "cage_unique_space_id" {
  description = "Cage unique space ID"
  type        = string
}
variable "cabinet_unique_space_id" {
  description = "Cabinet unique space ID"
  type        = string
}
variable "patch_panel" {
  description = "Patch panel"
  type        = string
}
variable "patch_panel_name" {
  description = "Patch panel name"
  type        = string
}
variable "patch_panel_portA" {
  description = "Patch panel port A"
  type        = string
}
variable "patch_panel_portB" {
  description = "Patch panel port B"
  type        = string
}
variable "project_id" {
  description = "Project ID"
  type        = string
}
variable "registered_user" {
  description = "Registered user for notifications"
  type        = string
}

```

outputs.tf
```hcl
output "port_order" {
  value = equinix_fabric_port.order
  sensitive = true
}

output "port_order_id" {
  value = equinix_fabric_port.order.id
}

output "public_sp_connection" {
 value = module.create_port_2_public_sp_connection.primary_connection
 sensitive = true
}

output "public_sp_connection_id" {
 value = module.create_port_2_public_sp_connection.primary_connection_id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_port" "order" {
  type = "XF_PORT"
  name = var.port_name
  physical_ports_speed = var.physical_ports_speed
  connectivity_source_type = "COLO"
  project = {
    project_id = var.project_id
  }
  order = {
    purchase_order = var.purchase_order_number
  }
  account = {
    account_number = var.account_number
  }
  location = {
    region     = "AMER"
    metro_name = "Silicon Valley"
    metro_code = var.metro_code
    ibx = var.ibx
  }
  physical_ports_type = var.physical_ports_type
  demarcation_point_ibx = var.demarcation_point_ibx
  redundancy = {
    priority = "PRIMARY"
  }
  encapsulation = {
    type = "DOT1Q"
    tag_protocol_id = "0x8100"
  }
  lag_enabled = false
  settings = {
    package_type = "STANDARD"
    shared_port_type = false
  }
  physical_ports = [
    {
      type = "XF_PHYSICAL_PORT"
      id = var.physical_port_id
      state = "PROVISIONED"
      bandwidth = 0
      uuid = var.physical_port_id
      demarcation_point = {
        cage_unique_space_id = var.cage_unique_space_id
        cabinet_unique_space_id = var.cabinet_unique_space_id
        connector_type = "SC"
        patch_panel = var.patch_panel
        patch_panel_name = var.patch_panel_name
        patch_panel_portA = var.patch_panel_portA
        patch_panel_portB = var.patch_panel_portB
        ibx = "SV5"
      }
      settings = {
        shared_port_type = "NA"
        shared_port_product = "NA"
        package_type = "STANDARD"
      }
    }
  ]
  notifications = [
    {
      type = "TECHNICAL"
      registered_users = [
        var.registered_user
      ]
    },
    {
      type = "NOTIFICATION"
      registered_users = [
        var.registered_user
      ]
    }
  ]
  physical_ports_count = 1
}

module "create_port_2_public_sp_connection" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_uuid = var.aside_port_uuid
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_public_sp_connection"></a> [create\_port\_2\_public\_sp\_connection](#module\_create\_port\_2\_public\_sp\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_port.order](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_port) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number | `string` | n/a | yes |
| <a name="input_aside_port_uuid"></a> [aside\_port\_uuid](#input\_aside\_port\_uuid) | Equinix A-Side Port UUID | `string` | n/a | yes |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_cabinet_unique_space_id"></a> [cabinet\_unique\_space\_id](#input\_cabinet\_unique\_space\_id) | Cabinet unique space ID | `string` | n/a | yes |
| <a name="input_cage_unique_space_id"></a> [cage\_unique\_space\_id](#input\_cage\_unique\_space\_id) | Cage unique space ID | `string` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_connectivity_source_type"></a> [connectivity\_source\_type](#input\_connectivity\_source\_type) | Connectivity source type | `string` | `"COLO"` | no |
| <a name="input_demarcation_point_ibx"></a> [demarcation\_point\_ibx](#input\_demarcation\_point\_ibx) | Demarcation point IBX | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_ibx"></a> [ibx](#input\_ibx) | IBX | `string` | n/a | yes |
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code) | Metro code | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | Organization ID | `string` | n/a | yes |
| <a name="input_patch_panel"></a> [patch\_panel](#input\_patch\_panel) | Patch panel | `string` | n/a | yes |
| <a name="input_patch_panel_name"></a> [patch\_panel\_name](#input\_patch\_panel\_name) | Patch panel name | `string` | n/a | yes |
| <a name="input_patch_panel_portA"></a> [patch\_panel\_portA](#input\_patch\_panel\_portA) | Patch panel port A | `string` | n/a | yes |
| <a name="input_patch_panel_portB"></a> [patch\_panel\_portB](#input\_patch\_panel\_portB) | Patch panel port B | `string` | n/a | yes |
| <a name="input_physical_port_id"></a> [physical\_port\_id](#input\_physical\_port\_id) | Physical port ID | `string` | n/a | yes |
| <a name="input_physical_ports_speed"></a> [physical\_ports\_speed](#input\_physical\_ports\_speed) | Physical ports speed | `number` | `1000` | no |
| <a name="input_physical_ports_type"></a> [physical\_ports\_type](#input\_physical\_ports\_type) | Physical ports type | `string` | `"1000BASE_LX"` | no |
| <a name="input_port_name"></a> [port\_name](#input\_port\_name) | Port name | `string` | `"panthers-CX-SV5-NL-Dot1q-STD-1G-PRI-JP-170"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_registered_user"></a> [registered\_user](#input\_registered\_user) | Registered user for notifications | `string` | n/a | yes |
| <a name="input_tag_protocol_id"></a> [tag\_protocol\_id](#input\_tag\_protocol\_id) | Tag protocol ID | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_port_order"></a> [port\_order](#output\_port\_order) | n/a |
| <a name="output_port_order_id"></a> [port\_order\_id](#output\_port\_order\_id) | n/a |
| <a name="output_public_sp_connection"></a> [public\_sp\_connection](#output\_public\_sp\_connection) | n/a |
| <a name="output_public_sp_connection_id"></a> [public\_sp\_connection\_id](#output\_public\_sp\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
