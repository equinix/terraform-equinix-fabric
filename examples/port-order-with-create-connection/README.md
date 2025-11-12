# Fabric Port to Fabric Public Service Profile Connection

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Public Service Profile.

It leverages the Equinix Terraform Provider, equinix_fabric_port Terraform resource, equinix_fabric_port Terraform datasource and the Fabric Port Connection
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
cd terraform-equinix-fabric/examples/port-order-with-create-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

physical_ports_type         = "1000BASE_LX"
physical_ports_speed        = 1000
connectivity_source_type    = "COLO"
account_number              = "1234567"
metro_code                  = "SV"
ibx                         = "SV1"
demarcation_point_ibx       = "SV1"
cage_unique_space_id        = "CAGE-001"
cabinet_unique_space_id     = "CAB-001"
patch_panel                 = "PP-01"
project_id                  = "project-001"
registered_user             = "user@example.com"
physical_ports_count        = 1
tag_protocol_id             = "0x8100"
connector_type              = "SC"
package_type                = "STANDARD"
priority                    = "PRIMARY"
encapsulation_type          = "DOT1Q"

connection_name       = "PortOrderCreateConnection"
connection_type       = "EVPL_VC"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com"]
bandwidth             = 50
purchase_order_number = "PO-123456"
aside_vlan_tag        = 2000

zside_ap_type         = "SP"
zside_ap_profile_type = "L2_PROFILE"
zside_location        = "SV"
zside_sp_name         = "Test-SP"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 4.9.0"
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
  description = "Order number"
  type        = string
  default     = ""
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
variable "project_id" {
  description = "Project ID"
  type        = string
}
variable "registered_user" {
  description = "Registered user for notifications"
  type        = string
}
variable "physical_ports_count" {
  description = "Physical ports count"
  type        = number
  default     = 1
}
variable "tag_protocol_id" {
    description = "Tag protocol ID"
    type        = string
}
variable "connector_type" {
    description = "Connector type"
    type        = string
}
variable "package_type" {
    description = "Package type"
    type        = string
    default     = "STANDARD"
}
variable "priority" {
    description = "Redundancy priority"
    type        = string
}
variable "encapsulation_type" {
    description = "Encapsulation type"
    type        = string
}
variable "lag_enabled" {
    description = "LAG enabled"
    type        = bool
}
variable "shared_port_type" {
    description = "Shared port type"
    type        = bool
}
variable "type" {
    description = "Physical port type"
    type        = string
}
```

outputs.tf
```hcl
output "port_uuid" {
  value = equinix_fabric_port.order.id
}
output "port_state" {
  value = data.equinix_fabric_port.check_active.state
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
  physical_ports_speed = var.physical_ports_speed
  connectivity_source_type = var.connectivity_source_type
  project = {
    project_id = var.project_id
  }
  account = {
    account_number = var.account_number
  }
  location = {
    metro_code = var.metro_code
  }
  physical_ports_type = var.physical_ports_type
  demarcation_point_ibx = var.demarcation_point_ibx
  redundancy = {
    priority = var.priority
  }
  encapsulation = {
    type = var.encapsulation_type
    tag_protocol_id = var.tag_protocol_id
  }
  lag_enabled = var.lag_enabled
  settings = {
    package_type = var.package_type
    shared_port_type = var.shared_port_type
  }
  physical_ports = [
    {
      type = var.type
      demarcation_point = {
        cage_unique_space_id = var.cage_unique_space_id
        cabinet_unique_space_id = var.cabinet_unique_space_id
        connector_type = var.connector_type
        patch_panel = var.patch_panel
        ibx = var.ibx
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
  physical_ports_count = var.physical_ports_count
}

resource "time_sleep" "wait_for_activation" {
  depends_on      = [equinix_fabric_port.order]
  create_duration = "5m"
}

data "equinix_fabric_port" "check_active" {
  depends_on = [time_sleep.wait_for_activation]
  uuid       = equinix_fabric_port.order.id
}

resource "null_resource" "port_active_check" {
  depends_on = [data.equinix_fabric_port.check_active]

  lifecycle {
    precondition {
      condition     = data.equinix_fabric_port.check_active.state == "ACTIVE"
      error_message = "Port must be ACTIVE (current: ${data.equinix_fabric_port.check_active.state})"
    }
  }
}

module "create_port_2_public_sp_connection" {
  depends_on = [null_resource.port_active_check]
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_uuid = equinix_fabric_port.order.id
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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 4.9.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_public_sp_connection"></a> [create\_port\_2\_public\_sp\_connection](#module\_create\_port\_2\_public\_sp\_connection) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_port.order](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_port) | resource |
| [null_resource.port_active_check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_for_activation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [equinix_fabric_port.check_active](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_port) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number | `string` | n/a | yes |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | Vlan Tag information, outer vlanSTag for QINQ connections | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_cabinet_unique_space_id"></a> [cabinet\_unique\_space\_id](#input\_cabinet\_unique\_space\_id) | Cabinet unique space ID | `string` | n/a | yes |
| <a name="input_cage_unique_space_id"></a> [cage\_unique\_space\_id](#input\_cage\_unique\_space\_id) | Cage unique space ID | `string` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_connectivity_source_type"></a> [connectivity\_source\_type](#input\_connectivity\_source\_type) | Connectivity source type | `string` | `"COLO"` | no |
| <a name="input_connector_type"></a> [connector\_type](#input\_connector\_type) | Connector type | `string` | n/a | yes |
| <a name="input_demarcation_point_ibx"></a> [demarcation\_point\_ibx](#input\_demarcation\_point\_ibx) | Demarcation point IBX | `string` | n/a | yes |
| <a name="input_encapsulation_type"></a> [encapsulation\_type](#input\_encapsulation\_type) | Encapsulation type | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_ibx"></a> [ibx](#input\_ibx) | IBX | `string` | n/a | yes |
| <a name="input_lag_enabled"></a> [lag\_enabled](#input\_lag\_enabled) | LAG enabled | `bool` | n/a | yes |
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code) | Metro code | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Package type | `string` | `"STANDARD"` | no |
| <a name="input_patch_panel"></a> [patch\_panel](#input\_patch\_panel) | Patch panel | `string` | n/a | yes |
| <a name="input_physical_ports_count"></a> [physical\_ports\_count](#input\_physical\_ports\_count) | Physical ports count | `number` | `1` | no |
| <a name="input_physical_ports_speed"></a> [physical\_ports\_speed](#input\_physical\_ports\_speed) | Physical ports speed | `number` | `1000` | no |
| <a name="input_physical_ports_type"></a> [physical\_ports\_type](#input\_physical\_ports\_type) | Physical ports type | `string` | `"1000BASE_LX"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | Redundancy priority | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Order number | `string` | `""` | no |
| <a name="input_registered_user"></a> [registered\_user](#input\_registered\_user) | Registered user for notifications | `string` | n/a | yes |
| <a name="input_shared_port_type"></a> [shared\_port\_type](#input\_shared\_port\_type) | Shared port type | `bool` | n/a | yes |
| <a name="input_tag_protocol_id"></a> [tag\_protocol\_id](#input\_tag\_protocol\_id) | Tag protocol ID | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Physical port type | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_port_state"></a> [port\_state](#output\_port\_state) | n/a |
| <a name="output_port_uuid"></a> [port\_uuid](#output\_port\_uuid) | n/a |
| <a name="output_public_sp_connection_id"></a> [public\_sp\_connection\_id](#output\_public\_sp\_connection\_id) | n/a |
<!-- END_TF_DOCS -->