# Fabric Cloud Router to Fabric Port Connection with Route Filters

This example shows how to leverage the [Fabric Cloud Router Route Filters Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-route-filters)
to add Route Filters to a Fabric Connection from a Fabric Cloud Router to Fabric Port.

It leverages the Equinix Terraform Provider, the Fabric Cloud Router Connection
Module, the Fabric Cloud Router Routing Protocols Module, and the Fabric Cloud Router Route Filters Module,
to setup the connection, routing protocols, and route filters based on the parameters you have
provided to this example; or based on the pattern you see used in this example it will allow
you to create a more specific use case for your own needs.

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
cd terraform-equinix-fabric/examples/cloud-router-2-port-connection-with-route-filters
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id      = "<MyEquinixClientId>"
equinix_client_secret  = "<MyEquinixSecret>"


cloud_router_name = "cloud_router_alpha"
cloud_router_type = "XF_ROUTER"
cloud_router_metro_code = "DC"
cloud_router_package = "STANDARD"

project_id = "<Equinix Fabric Project Id>"
account_number = "<Equinix account number>"

notifications_type       = "ALL"
notifications_emails     = ["example@equinix.com","test1@equinix.com"]
purchase_order_number    = "1-323292"
connection_name          = "fcr_2_port"
connection_type          = "IP_VC"
bandwidth                = 50
zside_ap_type            = "COLO"
zside_vlan_tag           = "2711"
zside_location           = "SV"
zside_port_name          = "<Equinix Port Name>"

routing_protocol_direct_rp_name = "DRP_PFCR"
routing_protocol_direct_ipv4_ip = "10.2.1.1/30"
routing_protocol_bgp_rp_name = "BGPRP_PFCR"
routing_protocol_bgp_ipv4_ip = "10.2.1.2/30"
routing_protocol_bgp_customer_asn = 4007

route_filter_direction = "INBOUND"
route_filter_policy_name = "rf_policy_PFCR"
route_filter_policy_type = "BGP_IPv4_PREFIX_FILTER"

route_filter_rules = [
  {
    name = "rule_1",
    prefix = "192.168.0.0/24",
    prefix_match = "exact",
    description = "first rule on route filter"
  },
  {
    name = "rule_2",
    prefix = "192.168.1.0/24",
    prefix_match = "or_longer",
    description = "second rule on route filter"
  }
]


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
variable "zside_port_name" {
  description = "Equinix Zside Port Name"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_vlan_tag" {
  description = "Access point protocol Vlan tag number for DOT1Q or QINQ connections"
  default     = ""
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = "SP"
}

variable "cloud_router_name" {
  description = "Name of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_type" {
  description = "Type of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_metro_code" {
  description = "Name of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_package" {
  description = "Package of the cloud router created for the connection"
  type        = string
}

variable "project_id" {
  description = "Id of the Fabric Project for the resources to be created in"
  type        = string
}

variable "account_number" {
  description = "Account number for the cloud router creation"
  type        = number
}

variable "route_filter_direction" {
  description = "Direction of the route filtering [INBOUND or OUTBOUND]"
  type        = string
}

variable "route_filter_policy_name" {
  description = "Name of the route filter policy that will be created in this module"
  type        = string
}

variable "route_filter_policy_type" {
  description = "Type of the route filter policy. Should be one of: BGP_IPv4_PREFIX_FILTER, BGP_IPv6_PREFIX_FILTER"
  type        = string
}

variable "route_filter_rules" {
  description = "List of route filter rules to add to the created route filter policy"
  type = list(object({
    prefix       = string,
    name         = optional(string),
    description  = optional(string),
    prefix_match = optional(string),
  }))
}

variable "routing_protocol_direct_rp_name" {
  description = "Name of the Direct Routing Protocol Added to the Cloud Router Connection"
  type = string
}

variable "routing_protocol_direct_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type = string
}

variable "routing_protocol_bgp_rp_name" {
  description = "Ipv4 Ip address for Cloud Router Bgp Routing Protocol"
}

variable "routing_protocol_bgp_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type = string
}

variable "routing_protocol_bgp_customer_asn" {
  description = "Customer ASN number for BGP Routing Protocol"
  type = number
}
```

outputs.tf
```hcl
output "port_connection" {
  value = module.cloud_router_port_connection.primary_connection
  sensitive = true
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_cloud_router" "this" {
  type = var.cloud_router_type
  name = var.cloud_router_name
  location {
    metro_code = var.cloud_router_metro_code
  }
  package {
    code = var.cloud_router_package
  }
  order {
    purchase_order_number = var.purchase_order_number
  }
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  project {
    project_id = var.project_id
  }
  account {
    account_number = var.account_number
  }
}

module "cloud_router_port_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  project_id            = var.project_id

  #Aside
  aside_fcr_uuid = equinix_fabric_cloud_router.this.id

  #Zside
  zside_ap_type   = var.zside_ap_type
  zside_location  = var.zside_location
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
}

module "cloud_router_connection_routing_protocols" {
  source = "equinix/fabric/equinix//modules/cloud-router-routing-protocols"
  connection_uuid = module.cloud_router_port_connection.primary_connection_id
  direct_rp_name = var.routing_protocol_direct_rp_name
  direct_equinix_ipv4_ip = var.routing_protocol_direct_ipv4_ip
  bgp_rp_name = var.routing_protocol_bgp_rp_name
  bgp_customer_peer_ipv4 = var.routing_protocol_bgp_ipv4_ip
  bgp_customer_asn = var.routing_protocol_bgp_customer_asn
}

module "cloud_router_route_filters" {
  depends_on = [ module.cloud_router_connection_routing_protocols ]
  source                            = "equinix/fabric/equinix//modules/cloud-router-route-filters"
  connection_id                     = module.cloud_router_port_connection.primary_connection_id
  connection_route_filter_direction = var.route_filter_direction

  route_filter_policy_name       = var.route_filter_policy_name
  route_filter_policy_project_id = var.project_id
  route_filter_policy_type       = var.route_filter_policy_type

  route_filter_rules = var.route_filter_rules
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
| <a name="module_cloud_router_connection_routing_protocols"></a> [cloud\_router\_connection\_routing\_protocols](#module\_cloud\_router\_connection\_routing\_protocols) | equinix/fabric/equinix//modules/cloud-router-routing-protocols | n/a |
| <a name="module_cloud_router_port_connection"></a> [cloud\_router\_port\_connection](#module\_cloud\_router\_port\_connection) | equinix/fabric/equinix//modules/cloud-router-connection | n/a |
| <a name="module_cloud_router_route_filters"></a> [cloud\_router\_route\_filters](#module\_cloud\_router\_route\_filters) | equinix/fabric/equinix//modules/cloud-router-route-filters | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_cloud_router.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_cloud_router) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number for the cloud router creation | `number` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_cloud_router_metro_code"></a> [cloud\_router\_metro\_code](#input\_cloud\_router\_metro\_code) | Name of the cloud router created for the connection | `string` | n/a | yes |
| <a name="input_cloud_router_name"></a> [cloud\_router\_name](#input\_cloud\_router\_name) | Name of the cloud router created for the connection | `string` | n/a | yes |
| <a name="input_cloud_router_package"></a> [cloud\_router\_package](#input\_cloud\_router\_package) | Package of the cloud router created for the connection | `string` | n/a | yes |
| <a name="input_cloud_router_type"></a> [cloud\_router\_type](#input\_cloud\_router\_type) | Type of the cloud router created for the connection | `string` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Id of the Fabric Project for the resources to be created in | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_route_filter_direction"></a> [route\_filter\_direction](#input\_route\_filter\_direction) | Direction of the route filtering [INBOUND or OUTBOUND] | `string` | n/a | yes |
| <a name="input_route_filter_policy_name"></a> [route\_filter\_policy\_name](#input\_route\_filter\_policy\_name) | Name of the route filter policy that will be created in this module | `string` | n/a | yes |
| <a name="input_route_filter_policy_type"></a> [route\_filter\_policy\_type](#input\_route\_filter\_policy\_type) | Type of the route filter policy. Should be one of: BGP\_IPv4\_PREFIX\_FILTER, BGP\_IPv6\_PREFIX\_FILTER | `string` | n/a | yes |
| <a name="input_route_filter_rules"></a> [route\_filter\_rules](#input\_route\_filter\_rules) | List of route filter rules to add to the created route filter policy | <pre>list(object({<br>    prefix       = string,<br>    name         = optional(string),<br>    description  = optional(string),<br>    prefix_match = optional(string),<br>  }))</pre> | n/a | yes |
| <a name="input_routing_protocol_bgp_customer_asn"></a> [routing\_protocol\_bgp\_customer\_asn](#input\_routing\_protocol\_bgp\_customer\_asn) | Customer ASN number for BGP Routing Protocol | `number` | n/a | yes |
| <a name="input_routing_protocol_bgp_ipv4_ip"></a> [routing\_protocol\_bgp\_ipv4\_ip](#input\_routing\_protocol\_bgp\_ipv4\_ip) | Ipv4 Ip address for Cloud Router Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_routing_protocol_bgp_rp_name"></a> [routing\_protocol\_bgp\_rp\_name](#input\_routing\_protocol\_bgp\_rp\_name) | Ipv4 Ip address for Cloud Router Bgp Routing Protocol | `any` | n/a | yes |
| <a name="input_routing_protocol_direct_ipv4_ip"></a> [routing\_protocol\_direct\_ipv4\_ip](#input\_routing\_protocol\_direct\_ipv4\_ip) | Ipv4 Ip address for Cloud Router Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_routing_protocol_direct_rp_name"></a> [routing\_protocol\_direct\_rp\_name](#input\_routing\_protocol\_direct\_rp\_name) | Name of the Direct Routing Protocol Added to the Cloud Router Connection | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Zside Port Name | `string` | n/a | yes |
| <a name="input_zside_vlan_tag"></a> [zside\_vlan\_tag](#input\_zside\_vlan\_tag) | Access point protocol Vlan tag number for DOT1Q or QINQ connections | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_port_connection"></a> [port\_connection](#output\_port\_connection) | n/a |
<!-- END_TF_DOCS -->