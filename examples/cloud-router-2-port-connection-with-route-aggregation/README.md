# Fabric Cloud Router to Fabric Port Connection with Route Aggregations

This example shows how to leverage the [Fabric Cloud Router Route Aggregations Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/cloud-router-route-aggregations)
to add Route Aggregations to a Fabric Connection from a Fabric Cloud Router to Fabric Port.

It leverages the Equinix Terraform Provider, the Fabric Cloud Router Connection
Module, the Fabric Cloud Router Routing Protocols Module, and the Fabric Cloud Router Route Aggregations Module,
to setup the connection, routing protocols, and route aggregations based on the parameters you have
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
cd terraform-equinix-fabric/examples/cloud-router-2-port-connection-with-route-aggregation
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id       = "<MyEquinixClientId>"
equinix_client_secret   = "<MyEquinixSecret>"

cloud_router_type       = "XF_ROUTER"
cloud_router_name       = "terra_fcr"
cloud_router_metro_code = "SV"
cloud_router_package    = "STANDARD"

account_number          = "<equinix_Account_number>"
project_id              = "<project_id>"

notifications_emails    = ["test@gmail.com"]
notifications_type      = "ALL"
purchase_order_number   = "1-323292"
bandwidth               = 50
connection_name         = "terra_fcr_2_port"
connection_type         =  "IP_VC"
zside_ap_type           = "COLO"
zside_location          = "SV"
zside_port_name         = "<port_name>"
zside_vlan_tag          = "2720"

routing_protocol_direct_ipv4_ip     = "190.1.1.1/30"
routing_protocol_direct_rp_name     = "DIRECT_RP"
routing_protocol_bgp_rp_name        = "BGP_RP"
routing_protocol_bgp_customer_asn   = "100"
routing_protocol_bgp_ipv4_ip        =  "190.1.1.2"

route_aggregation_type          = "BGP_IPv4_PREFIX_AGGREGATION"
route_aggregation_name          = "terra-route-aggregation"
route_aggregation_description   = "Test aggregation policy"
route_aggregation_rules         = [
   {
     "name"         = "rule_1",
     "prefix"       = "192.168.0.0/24",
     "description"  = "first rule on route aggregation"
   },
   {
     "name"         = "rule_2",
     "prefix"       = "192.168.1.0/24",
     "description"  = "second rule on route aggregation"
   }
]
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source="equinix/equinix"
      version = "3.3.0"
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

variable "route_aggregation_type" {
  description = "Type of the route aggregation policy. Should be one of: BGP_IPv4_PREFIX_ROUTE_AGGREGATION"
  type        = string
}

variable "route_aggregation_name" {
  description = "Name of the route aggregation policy that will be created in this module"
  type        = string
}

variable "route_aggregation_description" {
  description = "Description of the route aggregation policy you're creating"
  type        = string
  default     = ""
}

variable "route_aggregation_rules" {
  description = "List of route aggregation rules to add to the created route aggrgeation policy"
  type = list(object({
    prefix       = string,
    name         = optional(string),
    description  = optional(string),
  }))
}
```

outputs.tf
```hcl
output "port_connection" {
  value = module.cloud_router_port_connection.primary_connection
  sensitive = true
}

output "port_connection_id" {
  value = module.cloud_router_port_connection.primary_connection_id
}

output "route_aggrgeation_id" {
  value = module.cloud_router_route_aggregation.route_aggregation.id
}

output "route_aggregation_rule_id" {
  value = module.cloud_router_route_aggregation.route_aggregation_rule.id
}

output "route_aggregation_connection_attachment_id" {
  value = module.cloud_router_route_aggregation.connection_route_aggregation.id
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

module "cloud_router_route_aggregation" {
  depends_on = [ module.cloud_router_connection_routing_protocols ]
  source                            = "equinix/fabric/equinix//modules/cloud-router-route-aggregations"
  route_aggregation_type            = var.route_aggregation_type
  route_aggregation_name            = var.route_aggregation_name
  route_aggregation_description     = var.route_aggregation_description
  route_aggregation_project_id = var.project_id

  route_aggregation_rules = var.route_aggregation_rules

  connection_id                     = module.cloud_router_port_connection.primary_connection_id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | 3.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_connection_routing_protocols"></a> [cloud\_router\_connection\_routing\_protocols](#module\_cloud\_router\_connection\_routing\_protocols) | equinix/fabric/equinix//modules/cloud-router-routing-protocols | n/a |
| <a name="module_cloud_router_port_connection"></a> [cloud\_router\_port\_connection](#module\_cloud\_router\_port\_connection) | equinix/fabric/equinix//modules/cloud-router-connection | n/a |
| <a name="module_cloud_router_route_aggregation"></a> [cloud\_router\_route\_aggregation](#module\_cloud\_router\_route\_aggregation) | equinix/fabric/equinix//modules/cloud-router-route-aggregations | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_cloud_router.this](https://registry.terraform.io/providers/equinix/equinix/3.3.0/docs/resources/fabric_cloud_router) | resource |

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
| <a name="input_route_aggregation_description"></a> [route\_aggregation\_description](#input\_route\_aggregation\_description) | Description of the route aggregation policy you're creating | `string` | `""` | no |
| <a name="input_route_aggregation_name"></a> [route\_aggregation\_name](#input\_route\_aggregation\_name) | Name of the route aggregation policy that will be created in this module | `string` | n/a | yes |
| <a name="input_route_aggregation_rules"></a> [route\_aggregation\_rules](#input\_route\_aggregation\_rules) | List of route aggregation rules to add to the created route aggrgeation policy | <pre>list(object({<br>    prefix       = string,<br>    name         = optional(string),<br>    description  = optional(string),<br>  }))</pre> | n/a | yes |
| <a name="input_route_aggregation_type"></a> [route\_aggregation\_type](#input\_route\_aggregation\_type) | Type of the route aggregation policy. Should be one of: BGP\_IPv4\_PREFIX\_ROUTE\_AGGREGATION | `string` | n/a | yes |
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
| <a name="output_port_connection_id"></a> [port\_connection\_id](#output\_port\_connection\_id) | n/a |
| <a name="output_route_aggregation_connection_attachment_id"></a> [route\_aggregation\_connection\_attachment\_id](#output\_route\_aggregation\_connection\_attachment\_id) | n/a |
| <a name="output_route_aggregation_rule_id"></a> [route\_aggregation\_rule\_id](#output\_route\_aggregation\_rule\_id) | n/a |
| <a name="output_route_aggrgeation_id"></a> [route\_aggrgeation\_id](#output\_route\_aggrgeation\_id) | n/a |
<!-- END_TF_DOCS -->
