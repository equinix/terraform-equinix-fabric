# Fabric Routing Protocols SubModule

The Fabric Routing Protocols Module will add Direct (and BGP if specified) Routing Protocol details to an
existing Fabric Connection.

Please refer to the routing-protocols example in this module's registry for more details on how to leverage the submodule.

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
variable "connection_uuid" {
  description = "Equinix Connection UUID to Apply the Routing Protocols to"
  type        = string
}
variable "direct_rp_name" {
  description = "Name of the Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv4_ip" {
  description = "IPv4 Address for Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv6_ip" {
  description = "IPv6 Address for Direct Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_rp_name" {
  description = "Name of the BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv4" {
  description = "Customer Peering IPv4 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv6" {
  description = "Customer Peering IPv6 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_enabled_ipv4" {
  description = "Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_enabled_ipv6" {
  description = "Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_customer_asn" {
  description = "Customer ASN for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_auth_key" {
  description = "BGP authorization key"
  type        = string
  default     = ""
}
```

 #outputs.tf
```hcl
output "direct_routing_protocol" {
  value = equinix_fabric_routing_protocol.direct
}

output "bgp_routing_protocol" {
  value = var.bgp_rp_name != "" ? equinix_fabric_routing_protocol.bgp[0] : null
}

output "direct_routing_protocol_id" {
  value = equinix_fabric_routing_protocol.direct.id
}

output "bgp_routing_protocol_id" {
  value = var.bgp_rp_name != "" ? equinix_fabric_routing_protocol.bgp[0].id : null
}
```

 #main.tf
```hcl
resource "equinix_fabric_routing_protocol" "direct" {
  connection_uuid = var.connection_uuid
  name            = var.direct_rp_name
  type            = "DIRECT"
  direct_ipv4 {
    equinix_iface_ip = var.direct_equinix_ipv4_ip
  }
  dynamic "direct_ipv6" {
    for_each = var.direct_equinix_ipv6_ip != "" ? [1] : []
    content {
      equinix_iface_ip = var.direct_equinix_ipv6_ip
    }
  }
}

resource "equinix_fabric_routing_protocol" "bgp" {
  count = var.bgp_rp_name != "" ? 1 : 0
  depends_on = [
    equinix_fabric_routing_protocol.direct
  ]

  connection_uuid = var.connection_uuid
  name            = var.bgp_rp_name
  type            = "BGP"

  customer_asn = var.bgp_customer_asn
  bgp_auth_key = var.bgp_auth_key != "" ? var.bgp_auth_key : null

  bgp_ipv4 {
    enabled          = var.bgp_enabled_ipv4
    customer_peer_ip = var.bgp_customer_peer_ipv4
  }
  dynamic "bgp_ipv6" {
    for_each = var.bgp_customer_peer_ipv6 != "" ? [1] : []
    content {
      customer_peer_ip = var.bgp_customer_peer_ipv6
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
| [equinix_fabric_routing_protocol.bgp](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |
| [equinix_fabric_routing_protocol.direct](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_auth_key"></a> [bgp\_auth\_key](#input\_bgp\_auth\_key) | BGP authorization key | `string` | `""` | no |
| <a name="input_bgp_customer_asn"></a> [bgp\_customer\_asn](#input\_bgp\_customer\_asn) | Customer ASN for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv4"></a> [bgp\_customer\_peer\_ipv4](#input\_bgp\_customer\_peer\_ipv4) | Customer Peering IPv4 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv6"></a> [bgp\_customer\_peer\_ipv6](#input\_bgp\_customer\_peer\_ipv6) | Customer Peering IPv6 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_enabled_ipv4"></a> [bgp\_enabled\_ipv4](#input\_bgp\_enabled\_ipv4) | Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_enabled_ipv6"></a> [bgp\_enabled\_ipv6](#input\_bgp\_enabled\_ipv6) | Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_rp_name"></a> [bgp\_rp\_name](#input\_bgp\_rp\_name) | Name of the BGP Routing Protocol | `string` | `""` | no |
| <a name="input_connection_uuid"></a> [connection\_uuid](#input\_connection\_uuid) | Equinix Connection UUID to Apply the Routing Protocols to | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv4_ip"></a> [direct\_equinix\_ipv4\_ip](#input\_direct\_equinix\_ipv4\_ip) | IPv4 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv6_ip"></a> [direct\_equinix\_ipv6\_ip](#input\_direct\_equinix\_ipv6\_ip) | IPv6 Address for Direct Routing Protocol | `string` | `""` | no |
| <a name="input_direct_rp_name"></a> [direct\_rp\_name](#input\_direct\_rp\_name) | Name of the Direct Routing Protocol | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bgp_routing_protocol"></a> [bgp\_routing\_protocol](#output\_bgp\_routing\_protocol) | n/a |
| <a name="output_bgp_routing_protocol_id"></a> [bgp\_routing\_protocol\_id](#output\_bgp\_routing\_protocol\_id) | n/a |
| <a name="output_direct_routing_protocol"></a> [direct\_routing\_protocol](#output\_direct\_routing\_protocol) | n/a |
| <a name="output_direct_routing_protocol_id"></a> [direct\_routing\_protocol\_id](#output\_direct\_routing\_protocol\_id) | n/a |
<!-- END_TF_DOCS -->
