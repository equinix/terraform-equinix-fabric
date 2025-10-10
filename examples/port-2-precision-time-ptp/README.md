# Fabric Port to Equinix Precision Time Connection + PTP Time Service Configuration

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Equinix Precision Time PTP Service Profile.
It also creates an PTP Configured Time Service on top of the created connection.

It leverages the Equinix Terraform Provider, equinix_fabric_precision_time_service Terraform resource, and the Fabric Port Connection
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
cd terraform-equinix-fabric/examples/port-2-precision-time-ptp
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "MyEquinixClientId"
equinix_client_secret  = "MyEquinixSecret"

connection_name       = "Port2PublicSP"
connection_type       = "EVPL_VC"
notifications_type    = "ALL"
notifications_emails  = ["example@equinix.com"]
bandwidth             = 5
purchase_order_number = "1-323292"
aside_port_name       = "sit-001-CX-SV1-NL-Dot1q-BO-10G-PRI-JP-34"
aside_vlan_tag        = "1333"
zside_ap_type         = "SP"
zside_ap_profile_type = "L2_PROFILE"
zside_location        = "SV"
zside_sp_name         = "Equinix Precision Time PTP Global UAT"

precision_time_ptp_name                 = "PTP_EPT"
precision_time_ptp_description          = "PTP Configured Precision Time Service"
precision_time_ptp_package_code         = "PTP_STANDARD"
precision_time_ptp_ipv4_primary         = "192.168.254.241"
precision_time_ptp_ipv4_secondary       = "192.168.254.242"
precision_time_ptp_ipv4_network_mask    = "255.255.255.240"
precision_time_ptp_ipv4_default_gateway = "192.168.254.254"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.2"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 3.5.0"
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
variable "aside_port_name" {
  description = "Equinix A-Side Port Name"
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
variable "precision_time_ptp_name" {
  description = "Precision Time Service Name"
  type        = string
}
variable "precision_time_ptp_package_code" {
  description = "Precision Time Service Package Code"
  type        = string
}
variable "precision_time_ptp_ipv4_primary" {
  description = "Precision Time Service Primary Ipv4 value"
  type        = string
}
variable "precision_time_ptp_ipv4_secondary" {
  description = "Precision Time Service Secondary Ipv4 value"
  type        = string
}
variable "precision_time_ptp_ipv4_network_mask" {
  description = "Precision Time Service Ipv4 Network Mask value"
  type        = string
}
variable "precision_time_ptp_ipv4_default_gateway" {
  description = "Precision Time Service Ipv4 Default Gateway value"
  type        = string
}

variable "precision_time_ptp_advance_configuration" {
  description = "Precision Time Service PTP Advance Configuration Details"
  type = object({
    time_scale             = string
    domain                 = number
    priority1              = number
    priority2              = number
    log_announce_interval  = number
    log_sync_interval      = number
    log_delay_req_interval = number
    transport_mode         = string
    grant_time             = number
  })
  default = null
}
```

outputs.tf
```hcl
output "port_2_ptp_connection_id" {
  value = module.create_port_2_precision_time_ptp_service_profile.primary_connection_id
}

output "ptp_ept_resource_id" {
  value = equinix_fabric_precision_time_service.ptp.id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "random_integer" "random_vlan_tag" {
  min = 50
  max = 2549
}

output "random_vlan_tag" {
  value = random_integer.random_vlan_tag.result
}

module "create_port_2_precision_time_ptp_service_profile" {
  source = "equinix/fabric/equinix//modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = tostring(random_integer.random_vlan_tag.result)

  # Z-side
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_location        = var.zside_location
  zside_sp_name         = var.zside_sp_name
}

resource "equinix_fabric_precision_time_service" "ptp" {
  type = "PTP"
  name = var.precision_time_ptp_name
  package = {
    code = var.precision_time_ptp_package_code
  }
  connections = [
    {
      uuid = module.create_port_2_precision_time_ptp_service_profile.primary_connection_id
    }
  ]
  ipv4 = {
    primary         = var.precision_time_ptp_ipv4_primary
    secondary       = var.precision_time_ptp_ipv4_secondary
    network_mask    = var.precision_time_ptp_ipv4_network_mask
    default_gateway = var.precision_time_ptp_ipv4_default_gateway
  }
  ptp_advanced_configuration = var.precision_time_ptp_advance_configuration != null ? var.precision_time_ptp_advance_configuration : null
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 3.5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_port_2_precision_time_ptp_service_profile"></a> [create\_port\_2\_precision\_time\_ptp\_service\_profile](#module\_create\_port\_2\_precision\_time\_ptp\_service\_profile) | equinix/fabric/equinix//modules/port-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_precision_time_service.ptp](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_precision_time_service) | resource |
| [random_integer.random_vlan_tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_precision_time_ptp_advance_configuration"></a> [precision\_time\_ptp\_advance\_configuration](#input\_precision\_time\_ptp\_advance\_configuration) | Precision Time Service PTP Advance Configuration Details | <pre>object({<br>    time_scale             = string<br>    domain                 = number<br>    priority1              = number<br>    priority2              = number<br>    log_announce_interval  = number<br>    log_sync_interval      = number<br>    log_delay_req_interval = number<br>    transport_mode         = string<br>    grant_time             = number<br>  })</pre> | `null` | no |
| <a name="input_precision_time_ptp_ipv4_default_gateway"></a> [precision\_time\_ptp\_ipv4\_default\_gateway](#input\_precision\_time\_ptp\_ipv4\_default\_gateway) | Precision Time Service Ipv4 Default Gateway value | `string` | n/a | yes |
| <a name="input_precision_time_ptp_ipv4_network_mask"></a> [precision\_time\_ptp\_ipv4\_network\_mask](#input\_precision\_time\_ptp\_ipv4\_network\_mask) | Precision Time Service Ipv4 Network Mask value | `string` | n/a | yes |
| <a name="input_precision_time_ptp_ipv4_primary"></a> [precision\_time\_ptp\_ipv4\_primary](#input\_precision\_time\_ptp\_ipv4\_primary) | Precision Time Service Primary Ipv4 value | `string` | n/a | yes |
| <a name="input_precision_time_ptp_ipv4_secondary"></a> [precision\_time\_ptp\_ipv4\_secondary](#input\_precision\_time\_ptp\_ipv4\_secondary) | Precision Time Service Secondary Ipv4 value | `string` | n/a | yes |
| <a name="input_precision_time_ptp_name"></a> [precision\_time\_ptp\_name](#input\_precision\_time\_ptp\_name) | Precision Time Service Name | `string` | n/a | yes |
| <a name="input_precision_time_ptp_package_code"></a> [precision\_time\_ptp\_package\_code](#input\_precision\_time\_ptp\_package\_code) | Precision Time Service Package Code | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_port_2_ptp_connection_id"></a> [port\_2\_ptp\_connection\_id](#output\_port\_2\_ptp\_connection\_id) | n/a |
| <a name="output_ptp_ept_resource_id"></a> [ptp\_ept\_resource\_id](#output\_ptp\_ept\_resource\_id) | n/a |
| <a name="output_random_vlan_tag"></a> [random\_vlan\_tag](#output\_random\_vlan\_tag) | n/a |
<!-- END_TF_DOCS -->
