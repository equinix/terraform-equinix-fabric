# Equinix Fabric Internet Access

Creates everything needed for an Equinix Internet Access service:

1. An `IA_VC` connection from a port to the Internet Access service profile (`equinix_fabric_connection`) on the given VLAN tag.
2. An IP block (`equinix_fabric_ip_block`) used as a customer route.
3. The `equinix_fabric_internet_access_service` attached to the connection and the IP block.

Please refer to the `internet-access` example for usage details.

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
      version = ">= 5.4.0"
    }
  }
}
```

#variables.tf
 ```hcl
variable "name" {
  description = "The name of the EIA service"
  type        = string
}

variable "type" {
  description = "Type of the EIA service. One of: SINGLE_IA, DUAL_IA"
  type        = string
}

variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
}

variable "account_number" {
  description = "Account number"
  type        = string
}

variable "billing_type" {
  description = "Billing type of the EIA service. One of: FIXED, USAGE_BASED, BURST_BASED"
  type        = string
}

variable "bandwidth" {
  description = "Bandwidth of the service"
  type        = number
}

variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = null
}

variable "routing_protocol_type" {
  description = "Routing protocol type. One of: BGP, DIRECT, STATIC"
  type        = string
}

variable "port_uuid" {
  description = "UUID of the Fabric port the IA_VC connection starts from"
  type        = string
}

variable "service_profile_uuid" {
  description = "UUID of the Equinix Internet Access service profile (IA_PROFILE)"
  type        = string
}

variable "metro_code" {
  description = "Two-letter metro code of the port and the service profile"
  type        = string
}

variable "connection_name" {
  description = "Name of the IA_VC connection created for the service"
  type        = string
}

variable "connection_bandwidth" {
  description = "Bandwidth of the IA_VC connection in Mbps"
  type        = number
}

variable "asn_uuid" {
  description = "BGP only. Unique identifier of the ASN (equinix_fabric_asn)"
  type        = string
  default     = null
}

variable "customer_asn" {
  description = "BGP only. Customer ASN. Valid range is 1-64495 or 65536-4199999999"
  type        = number
  default     = null
}

variable "customer_asn_range" {
  description = "BGP only. Customer ASN range. One of: BITS_16, BITS_32"
  type        = string
  default     = null
}

variable "bgp_auth_key" {
  description = "BGP only. BGP authentication key"
  type        = string
  default     = null
  sensitive   = true
}

variable "export_policy" {
  description = "BGP only. Export policy. One of: FULL, DEFAULT, FULL_DEFAULT, PARTIAL"
  type        = string
  default     = null
}

variable "notifications_emails" {
  description = "Emails notified about the Internet Access connection"
  type        = list(string)
}

variable "ip_block_prefix_length" {
  description = "Prefix length of the IP block attached as the customer route"
  type        = number
}

variable "ip_block_type" {
  description = "Type of the IP block used as the customer route. One of: IPV4_IP_BLOCK, IPV6_IP_BLOCK"
  type        = string
}

variable "vlan_tag" {
  description = "A-side VLAN tag of the IA_VC connection"
  type        = number
}
```

 #outputs.tf
```hcl
output "uuid" {
  description = "UUID of the Internet Access service"
  value       = equinix_fabric_internet_access_service.internet_access_service.uuid
}

output "state" {
  description = "Provisioning state of the service"
  value       = equinix_fabric_internet_access_service.internet_access_service.state
}

output "connection_uuid" {
  description = "UUID of the IA_VC connection attached to the service"
  value       = equinix_fabric_connection.ia_vc.uuid
}

output "ip_block_uuid" {
  description = "UUID of the IP block used as customer route"
  value       = equinix_fabric_ip_block.ip_block.uuid
}
```

 #main.tf
```hcl
data "equinix_fabric_port" "aside_port" {
  uuid = var.port_uuid
}

resource "equinix_fabric_connection" "ia_vc" {
  name      = var.connection_name
  type      = "IA_VC"
  bandwidth = var.connection_bandwidth

  notifications {
    type   = "ALL"
    emails = var.notifications_emails
  }

  project {
    project_id = var.project_id
  }

  redundancy {
    priority = "PRIMARY"
  }

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = data.equinix_fabric_port.aside_port.uuid
      }
      location {
        metro_code = var.metro_code
      }
      link_protocol {
        type       = one(data.equinix_fabric_port.aside_port.encapsulation).type
        vlan_tag   = one(data.equinix_fabric_port.aside_port.encapsulation).type == "DOT1Q" ? var.vlan_tag : null
        vlan_s_tag = one(data.equinix_fabric_port.aside_port.encapsulation).type == "QINQ" ? var.vlan_tag : null
      }
    }
  }

  z_side {
    access_point {
      type = "SP"
      profile {
        type = "IA_PROFILE"
        uuid = var.service_profile_uuid
      }
      location {
        metro_code = var.metro_code
      }
    }
  }
}

resource "equinix_fabric_ip_block" "ip_block" {
  type          = var.ip_block_type
  prefix_length = var.ip_block_prefix_length

  project = {
    project_id = var.project_id
  }

  location = {
    metro_code = var.metro_code
  }

  account = {
    account_number = var.account_number
  }
}

resource "equinix_fabric_internet_access_service" "internet_access_service" {
  name      = var.name
  type      = var.type
  bandwidth = var.bandwidth

  project = {
    project_id = var.project_id
  }

  account = {
    account_number = var.account_number
  }

  billing = {
    type = var.billing_type
  }

  order = var.purchase_order_number == null ? null : {
    purchase_order_number = var.purchase_order_number
  }

  routing_protocol = {
    type               = var.routing_protocol_type
    customer_asn       = var.customer_asn
    customer_asn_range = var.customer_asn_range
    bgp_auth_key       = var.bgp_auth_key
    export_policy      = var.export_policy

    asn = var.asn_uuid == null ? null : {
      uuid = var.asn_uuid
    }

    connections = [{
      uuid = equinix_fabric_connection.ia_vc.uuid
    }]

    customer_routes = [{
      ip_block = {
        uuid = equinix_fabric_ip_block.ip_block.uuid
      }
    }]
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 5.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 5.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection.ia_vc](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_internet_access_service.internet_access_service](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_internet_access_service) | resource |
| [equinix_fabric_ip_block.ip_block](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_ip_block) | resource |
| [equinix_fabric_port.aside_port](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_port) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number | `string` | n/a | yes |
| <a name="input_asn_uuid"></a> [asn\_uuid](#input\_asn\_uuid) | BGP only. Unique identifier of the ASN (equinix\_fabric\_asn) | `string` | `null` | no |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth of the service | `number` | n/a | yes |
| <a name="input_bgp_auth_key"></a> [bgp\_auth\_key](#input\_bgp\_auth\_key) | BGP only. BGP authentication key | `string` | `null` | no |
| <a name="input_billing_type"></a> [billing\_type](#input\_billing\_type) | Billing type of the EIA service. One of: FIXED, USAGE\_BASED, BURST\_BASED | `string` | n/a | yes |
| <a name="input_connection_bandwidth"></a> [connection\_bandwidth](#input\_connection\_bandwidth) | Bandwidth of the IA\_VC connection in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Name of the IA\_VC connection created for the service | `string` | n/a | yes |
| <a name="input_customer_asn"></a> [customer\_asn](#input\_customer\_asn) | BGP only. Customer ASN. Valid range is 1-64495 or 65536-4199999999 | `number` | `null` | no |
| <a name="input_customer_asn_range"></a> [customer\_asn\_range](#input\_customer\_asn\_range) | BGP only. Customer ASN range. One of: BITS\_16, BITS\_32 | `string` | `null` | no |
| <a name="input_export_policy"></a> [export\_policy](#input\_export\_policy) | BGP only. Export policy. One of: FULL, DEFAULT, FULL\_DEFAULT, PARTIAL | `string` | `null` | no |
| <a name="input_ip_block_prefix_length"></a> [ip\_block\_prefix\_length](#input\_ip\_block\_prefix\_length) | Prefix length of the IP block attached as the customer route | `number` | n/a | yes |
| <a name="input_ip_block_type"></a> [ip\_block\_type](#input\_ip\_block\_type) | Type of the IP block used as the customer route. One of: IPV4\_IP\_BLOCK, IPV6\_IP\_BLOCK | `string` | n/a | yes |
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code) | Two-letter metro code of the port and the service profile | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the EIA service | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Emails notified about the Internet Access connection | `list(string)` | n/a | yes |
| <a name="input_port_uuid"></a> [port\_uuid](#input\_port\_uuid) | UUID of the Fabric port the IA\_VC connection starts from | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `null` | no |
| <a name="input_routing_protocol_type"></a> [routing\_protocol\_type](#input\_routing\_protocol\_type) | Routing protocol type. One of: BGP, DIRECT, STATIC | `string` | n/a | yes |
| <a name="input_service_profile_uuid"></a> [service\_profile\_uuid](#input\_service\_profile\_uuid) | UUID of the Equinix Internet Access service profile (IA\_PROFILE) | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Type of the EIA service. One of: SINGLE\_IA, DUAL\_IA | `string` | n/a | yes |
| <a name="input_vlan_tag"></a> [vlan\_tag](#input\_vlan\_tag) | A-side VLAN tag of the IA\_VC connection | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_uuid"></a> [connection\_uuid](#output\_connection\_uuid) | UUID of the IA\_VC connection attached to the service |
| <a name="output_ip_block_uuid"></a> [ip\_block\_uuid](#output\_ip\_block\_uuid) | UUID of the IP block used as customer route |
| <a name="output_state"></a> [state](#output\_state) | Provisioning state of the service |
| <a name="output_uuid"></a> [uuid](#output\_uuid) | UUID of the Internet Access service |
<!-- END_TF_DOCS -->