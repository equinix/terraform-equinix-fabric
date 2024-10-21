# Fabric Cloud Router Connection SubModule

The Fabric Cloud Router Connection SubModule will create a connection from a Fabric Cloud Router to the following Z-Side
Access Points based on provided variable configuration:
1. Fabric Service Profile - SP Access Point Type
2. Fabric Port - COLO Access Point Type
3. Fabric Network - NETWORK Access Point Type

Please refer to the cloud-router-* examples in this module's registry for more details on how to leverage the submodule.

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
      version = ">= 2.9.0"
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
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
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
variable "zside_port_name" {
  description = "Equinix Zside Port Name"
  type        = string
  default     = ""
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  default     = ""
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
variable "zside_vlan_tag" {
  description = "Access point protocol Vlan tag number for DOT1Q or QINQ connections"
  default     = ""
}
variable "zside_vlan_inner_tag" {
  description = "Access point protocol Vlan tag number for QINQ connections"
  default     = ""
}
variable "zside_peering_type" {
  description = "Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  default     = "PRIVATE"
}
variable "zside_network_uuid" {
  description = "Network UUID"
  default     = ""
}
variable "zside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
  default     = ""
}
variable "zside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
  default     = ""
}
variable "zside_interface_type" {
  description = "Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_interface_id" {
  description = "Interface Id"
  type        = number
  default     = null
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "secondary_connection_name" {
  description = "Secondary Connection name"
  type        = string
  default     = ""
}
variable "secondary_bandwidth" {
  description = "Secondary Connection bandwidth in Mbps"
  type        = number
  default     = 50
}
variable "zside_sec_vd_uuid" {
  description = "Secondary Virtual Device UUID"
  type        = string
  default     = ""
}
variable "zside_sec_interface_type" {
  description = "Secondary Virtual Device Interface type - CLOUD, NETWORK"
  type        = string
  default     = ""
}
variable "zside_sec_interface_id" {
  description = "Secondary Interface Id"
  type        = number
  default     = null
}
variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
}
```

 #outputs.tf
```hcl
output "primary_connection_id" {
  value = equinix_fabric_connection.primary_cloud_router_connection.id
}
output "secondary_connection_id" {
  value = var.secondary_connection_name != "" ? equinix_fabric_connection.secondary_cloud_router_connection[0].id : null
}
```

 #main.tf
```hcl
data "equinix_fabric_service_profiles" "zside" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_fabric_sp_name]
  }
}
data "equinix_fabric_ports" "zside" {
  count = var.zside_ap_type == "COLO" ? 1 : 0
  filters {
    name = var.zside_port_name
  }
}


resource "equinix_fabric_connection" "primary_cloud_router_connection" {
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
  additional_info = var.additional_info != [] ? var.additional_info : null
  bandwidth       = var.bandwidth
  redundancy { priority = "PRIMARY" }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }
  a_side {
    access_point {
      type = "CLOUD_ROUTER"
      router {
        uuid = var.aside_fcr_uuid
      }
    }
  }
  dynamic "z_side" {
    #ports z_side type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside[0].id
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
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
        peering_type       = var.zside_peering_type
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside[0].id
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
      }
    }
  }
  dynamic "z_side" {
    #VD Z_Side Type
    for_each = var.zside_ap_type == "VD" ? [1] : []
    content {
      access_point {
        type = "VD"
        virtual_device {
          type = var.zside_vd_type
          uuid = var.zside_vd_uuid
        }
        interface {
          type = var.zside_interface_type != "" ? var.zside_interface_type : null
          id   = var.zside_interface_id != "" ? var.zside_interface_id : null
        }
      }
    }
  }
  dynamic "z_side" {
    for_each = var.zside_ap_type == "METAL_NETWORK" ? [1] : []
    content {
      access_point {
        type               = "METAL_NETWORK"
        authentication_key = var.zside_ap_authentication_key
      }
    }
  }
}

resource "equinix_fabric_connection" "secondary_cloud_router_connection" {
  count = var.secondary_connection_name != "" ? 1 : 0
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
  additional_info = var.additional_info != [] ? var.additional_info : null
  bandwidth       = var.secondary_bandwidth
  redundancy {
    priority = "SECONDARY"
    group    = one(equinix_fabric_connection.primary_cloud_router_connection.redundancy).group
  }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
  }
  a_side {
    access_point {
      type = "CLOUD_ROUTER"
      router {
        uuid = var.aside_fcr_uuid
      }
    }
  }
  dynamic "z_side" {
    #ports z_side type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside[0].id
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside[0].data[0].encapsulation).type == "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
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
        peering_type       = var.zside_peering_type
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside[0].id
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
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_ap_type == "VD" ? [1] : []
    content {
      access_point {
        type = "VD"
        virtual_device {
          type = var.zside_vd_type
          uuid = var.zside_sec_vd_uuid
        }
        interface {
          type = var.zside_sec_interface_type != "" ? var.zside_sec_interface_type : null
          id   = var.zside_sec_interface_id != "" ? var.zside_sec_interface_id : null
        }
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_ap_type == "METAL_NETWORK" ? [1] : []
    content {
      access_point {
        type               = "METAL_NETWORK"
        authentication_key = var.zside_ap_authentication_key
      }
    }
  }
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

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection.primary_cloud_router_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.secondary_cloud_router_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_service_profiles.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]` | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | `""` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Secondary Connection bandwidth in Mbps | `number` | `50` | no |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name | `string` | `""` | no |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_interface_id"></a> [zside\_interface\_id](#input\_zside\_interface\_id) | Interface Id | `number` | `null` | no |
| <a name="input_zside_interface_type"></a> [zside\_interface\_type](#input\_zside\_interface\_type) | Virtual Device Interface type - CLOUD, NETWORK | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_network_uuid"></a> [zside\_network\_uuid](#input\_zside\_network\_uuid) | Network UUID | `string` | `""` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `"PRIVATE"` | no |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Zside Port Name | `string` | `""` | no |
| <a name="input_zside_sec_interface_id"></a> [zside\_sec\_interface\_id](#input\_zside\_sec\_interface\_id) | Secondary Interface Id | `number` | `null` | no |
| <a name="input_zside_sec_interface_type"></a> [zside\_sec\_interface\_type](#input\_zside\_sec\_interface\_type) | Secondary Virtual Device Interface type - CLOUD, NETWORK | `string` | `""` | no |
| <a name="input_zside_sec_vd_uuid"></a> [zside\_sec\_vd\_uuid](#input\_zside\_sec\_vd\_uuid) | Secondary Virtual Device UUID | `string` | `""` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | `""` | no |
| <a name="input_zside_vd_type"></a> [zside\_vd\_type](#input\_zside\_vd\_type) | Virtual Device type - EDGE | `string` | `""` | no |
| <a name="input_zside_vd_uuid"></a> [zside\_vd\_uuid](#input\_zside\_vd\_uuid) | Virtual Device UUID | `string` | `""` | no |
| <a name="input_zside_vlan_inner_tag"></a> [zside\_vlan\_inner\_tag](#input\_zside\_vlan\_inner\_tag) | Access point protocol Vlan tag number for QINQ connections | `string` | `""` | no |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | Access point protocol Vlan tag number for DOT1Q or QINQ connections | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_connection_id"></a> [primary\_connection\_id](#output\_primary\_connection\_id) | n/a |
| <a name="output_secondary_connection_id"></a> [secondary\_connection\_id](#output\_secondary\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
