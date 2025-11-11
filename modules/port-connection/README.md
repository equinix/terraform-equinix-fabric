# Fabric Port Connection SubModule

The Fabric Port Connection Module will create a connection from a Fabric Port to the following Z-Side
Access Points based on provided variable configuration:
1. Fabric Service Profile - SP Access Point Type
2. Fabric Port - COLO Access Point Type

Please refer to the port-* examples in this module's registry for more details on how to leverage the submodule.

<!-- BEGIN_TF_DOCS -->
## Equinix Fabric Developer Documentation

To see the documentation for the APIs that the Fabric Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Fabric Developer Portal](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview)

## Modules File Content 

#versions.tf
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

#variables.tf
 ```hcl
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
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC, EVPLAN_VC, EPLAN_VC"
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
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "secondary_bandwidth" {
  description = "Connection bandwidth in Mbps for the secondary connection"
  type        = number
  default     = 0
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "term_length" {
  description = "Order Term Length"
  type        = number
  default     = 0
}
variable "aside_port_name" {
  description = "Equinix A-Side Port Name; your tagging must match the encapsulation type of the port (DOT1Q or QINQ)"
  type        = string
  default     = ""
}
variable "aside_secondary_port_name" {
  description = "Equinix A-Side Port Name; your tagging must match the encapsulation type of the port (DOT1Q or QINQ)"
  type        = string
  default     = ""
}
variable "aside_location" {
  description = "Aside metro code"
  type        = string
  default     = ""
}
variable "aside_vlan_tag" {
  description = "VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections)"
  type        = string
}
variable "aside_secondary_vlan_tag" {
  description = "Secondary VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections)"
  type        = string
  default = ""
}
variable "aside_vlan_inner_tag" {
  description = "VLan Tag information for QINQ connections"
  type        = string
  default     = ""
}
variable "aside_secondary_vlan_inner_tag" {
  description = "Secondary VLan Tag information for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - VD, SP, COLO, CLOUD_ROUTER, NETWORK"
  type        = string
  default     = ""
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  default     = ""
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
  default     = ""
}
variable "zside_location" {
  description = "Zside metro code"
  type        = string
  default     = ""
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "zside_port_name" {
  description = "Equinix Z-Side Port Name"
  type        = string
  default     = ""
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "zside_vlan_tag" {
  description = "VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_secondary_vlan_tag" {
  description = "Secondary VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_vlan_inner_tag" {
  description = "Inner VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_secondary_vlan_inner_tag" {
  description = "Secondary Inner VLan tag for QINQ connections"
  type        = string
  default     = ""
}
variable "zside_peering_type" {
  description = "Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  type        = string
  default     = ""
}
variable "zside_network_uuid" {
  description = "Equinix Network UUID"
  default     = ""
}
variable "zside_service_token_uuid" {
  description = "Service Token UUID"
  type        = string
  default     = ""
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
}
variable "role" {
  description = "Role of ETree network"
  type        = string
  default     = ""
}
variable "aside_port_uuid" {
  description = "Equinix A-Side Port UUID; use this instead of aside_port_name. Only one of aside_port_name or aside_port_uuid can be set."
  type        = string
  default     = ""
}
variable "zside_port_uuid" {
  description = "Equinix Z-Side Port UUID; use this instead of aside_port_name"
  type        = string
  default     = ""
}
```

 #outputs.tf
```hcl
output "primary_connection" {
  value = equinix_fabric_connection.primary_port_connection
}

output "secondary_connection" {
  value = var.aside_secondary_port_name != "" ? equinix_fabric_connection.secondary_port_connection[0] : null
}

output "primary_connection_id" {
  value = equinix_fabric_connection.primary_port_connection.id
}

output "secondary_connection_id" {
  value = var.aside_secondary_port_name != "" ? equinix_fabric_connection.secondary_port_connection[0].id : null
}
```

 #main.tf
```hcl
data "equinix_fabric_ports" "aside_port" {
  filter {
    property = var.aside_port_name != "" ? "/name" : "/uuid"
    operator = "="
    value    = var.aside_port_name != "" ? var.aside_port_name : var.aside_port_uuid
  }
}

data "equinix_fabric_ports" "aside_secondary_port" {
  count = var.aside_secondary_port_name != "" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    value    = var.aside_secondary_port_name
  }
}

data "equinix_fabric_service_profiles" "zside_sp" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_sp_name]
  }
}

data "equinix_fabric_ports" "zside_port" {
  count = var.zside_ap_type == "COLO" ? 1 : 0
  filter {
    property = var.zside_port_name != "" ? "/name" : "/uuid"
    operator = "="
    value    = var.zside_port_name != "" ? var.zside_port_name : var.zside_port_uuid
  }
}

resource "equinix_fabric_connection" "primary_port_connection" {
  name = var.connection_name
  type = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  dynamic "project" {
    for_each = var.project_id != "" ? [1] : []
    content {
      project_id = var.project_id
    }
  }
  bandwidth = var.bandwidth
  redundancy { priority = "PRIMARY" }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
    term_length = var.term_length >= 1 ? var.term_length: null
  }

  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = data.equinix_fabric_ports.aside_port.data.0.uuid
      }
      location {
        metro_code = var.aside_location != "" ? var.aside_location : null
      }
      link_protocol {
        type       = one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type
        vlan_tag   = one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type == "DOT1Q" ? var.aside_vlan_tag : null
        vlan_s_tag = one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type == "QINQ" ? var.aside_vlan_tag : null

        # This is adding ctag for any connection that is QINQ Aside AND not COLO on Zside OR when COLO on Zside is not QINQ Encapsulation Type
        vlan_c_tag = one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type == "QINQ" && (var.zside_ap_type != "COLO" || (var.zside_ap_type == "COLO" ? one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type != "QINQ" : false)) ? var.aside_vlan_inner_tag : null
      }
    }
  }

  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region != "" ? var.zside_seller_region : null
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
      }
    }
  }

  dynamic "z_side" {
    # Port Z_Side Type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside_port[0].data.0.uuid
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" && one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type != "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
        role = var.role != "" ? var.role : null
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }
}

resource "equinix_fabric_connection" "secondary_port_connection" {
  count = var.aside_secondary_port_name != "" ? 1 : 0
  name  = var.secondary_connection_name
  type  = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  dynamic "project" {
    for_each = var.project_id != "" ? [1] : []
    content {
      project_id = var.project_id
    }
  }
  bandwidth = var.secondary_bandwidth
  redundancy {
    priority = "SECONDARY"
    group    = one(equinix_fabric_connection.primary_port_connection.redundancy).group
  }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
    term_length = var.term_length >= 1 ? var.term_length: null
  }

  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = data.equinix_fabric_ports.aside_secondary_port[0].data.0.uuid
      }
      location {
        metro_code = var.aside_location != "" ? var.aside_location : null
      }
      link_protocol {
        type       = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type
        vlan_tag   = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "DOT1Q" ? var.aside_secondary_vlan_tag : null
        vlan_s_tag = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "QINQ" ? var.aside_secondary_vlan_tag : null

        # This is adding ctag for any connection that is QINQ Aside AND not COLO on Zside OR when COLO on Zside is not QINQ Encapsulation Type
        vlan_c_tag = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "QINQ" && (var.zside_ap_type != "COLO" || (var.zside_ap_type == "COLO" ? one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type != "QINQ" : false)) ? var.aside_secondary_vlan_inner_tag : null
      }
    }
  }

  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
      }
    }
  }

  dynamic "z_side" {
    # Port Z_Side Type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside_port[0].data.0.uuid
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "DOT1Q" ? var.zside_secondary_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_secondary_vlan_inner_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" && one(data.equinix_fabric_ports.aside_port.data.0.encapsulation).type != "QINQ" ? var.zside_secondary_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
        role = var.role != "" ? var.role : null
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }
}

check "port_name_uuid_mutual_exclusion" {
  assert {
    condition     = !(var.zside_port_name != "" && var.zside_port_uuid != "")
    error_message = "ERROR: Cannot set both zside_port_name and zside_port_uuid. Please set only one."
  }

  assert {
    condition     = !(var.aside_port_name != "" && var.aside_port_uuid != "")
    error_message = "ERROR: Cannot set both aside_port_name and aside_port_uuid. Please set only one."
  }
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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection.primary_port_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.secondary_port_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.aside_port](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_ports.aside_secondary_port](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_ports.zside_port](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_service_profiles.zside_sp](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values. | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aside_location"></a> [aside\_location](#input\_aside\_location) | Aside metro code | `string` | `""` | no |
| <a name="input_aside_port_name"></a> [aside\_port\_name](#input\_aside\_port\_name) | Equinix A-Side Port Name; your tagging must match the encapsulation type of the port (DOT1Q or QINQ) | `string` | `""` | no |
| <a name="input_aside_port_uuid"></a> [aside\_port\_uuid](#input\_aside\_port\_uuid) | Equinix A-Side Port UUID; use this instead of aside\_port\_name. Only one of aside\_port\_name or aside\_port\_uuid can be set. | `string` | `""` | no |
| <a name="input_aside_secondary_port_name"></a> [aside\_secondary\_port\_name](#input\_aside\_secondary\_port\_name) | Equinix A-Side Port Name; your tagging must match the encapsulation type of the port (DOT1Q or QINQ) | `string` | `""` | no |
| <a name="input_aside_secondary_vlan_inner_tag"></a> [aside\_secondary\_vlan\_inner\_tag](#input\_aside\_secondary\_vlan\_inner\_tag) | Secondary VLan Tag information for QINQ connections | `string` | `""` | no |
| <a name="input_aside_secondary_vlan_tag"></a> [aside\_secondary\_vlan\_tag](#input\_aside\_secondary\_vlan\_tag) | Secondary VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections) | `string` | `""` | no |
| <a name="input_aside_vlan_inner_tag"></a> [aside\_vlan\_inner\_tag](#input\_aside\_vlan\_inner\_tag) | VLan Tag information for QINQ connections | `string` | `""` | no |
| <a name="input_aside_vlan_tag"></a> [aside\_vlan\_tag](#input\_aside\_vlan\_tag) | VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections) | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC, EVPLAN\_VC, EPLAN\_VC | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | `""` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_role"></a> [role](#input\_role) | Role of ETree network | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Connection bandwidth in Mbps for the secondary connection | `number` | `0` | no |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | `""` | no |
| <a name="input_term_length"></a> [term\_length](#input\_term\_length) | Order Term Length | `number` | `0` | no |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `""` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - VD, SP, COLO, CLOUD\_ROUTER, NETWORK | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Zside metro code | `string` | `""` | no |
| <a name="input_zside_network_uuid"></a> [zside\_network\_uuid](#input\_zside\_network\_uuid) | Equinix Network UUID | `string` | `""` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `""` | no |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Z-Side Port Name | `string` | `""` | no |
| <a name="input_zside_port_uuid"></a> [zside\_port\_uuid](#input\_zside\_port\_uuid) | Equinix Z-Side Port UUID; use this instead of aside\_port\_name | `string` | `""` | no |
| <a name="input_zside_secondary_vlan_inner_tag"></a> [zside\_secondary\_vlan\_inner\_tag](#input\_zside\_secondary\_vlan\_inner\_tag) | Secondary Inner VLan tag for QINQ connections | `string` | `""` | no |
| <a name="input_zside_secondary_vlan_tag"></a> [zside\_secondary\_vlan\_tag](#input\_zside\_secondary\_vlan\_tag) | Secondary VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections | `string` | `""` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | `""` | no |
| <a name="input_zside_service_token_uuid"></a> [zside\_service\_token\_uuid](#input\_zside\_service\_token\_uuid) | Service Token UUID | `string` | `""` | no |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_vlan_inner_tag"></a> [zside\_vlan\_inner\_tag](#input\_zside\_vlan\_inner\_tag) | Inner VLan tag for QINQ connections | `string` | `""` | no |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | VLan Tag information for DOT1Q connections, and the outer VLan tag for QINQ connections | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_connection"></a> [primary\_connection](#output\_primary\_connection) | n/a |
| <a name="output_primary_connection_id"></a> [primary\_connection\_id](#output\_primary\_connection\_id) | n/a |
| <a name="output_secondary_connection"></a> [secondary\_connection](#output\_secondary\_connection) | n/a |
| <a name="output_secondary_connection_id"></a> [secondary\_connection\_id](#output\_secondary\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
