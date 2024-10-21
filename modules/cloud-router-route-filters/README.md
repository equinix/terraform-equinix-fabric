# Fabric Routing Protocols SubModule

The Fabric Route Filters Module will create a Route Filter Policy, add Route Filter Rules to it,
and attach the Route Filter Policy to an existing Fabric Connection.

Please refer to the cloud-router-2-port-connection-with-route-filters example in this module's
registry for more details on how to leverage the submodule.

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
variable "route_filter_policy_name" {
  description = "Name of the route filter policy that will be created in this module"
  type = string
}

variable "route_filter_policy_project_id" {
  description = "Project id where the route filter policy will be created. Should match the project id of the connection you would like to attach the route filter policy to"
  type = string
}

variable "route_filter_policy_type" {
  description = "Type of the route filter policy. Should be one of: BGP_IPv4_PREFIX_FILTER, BGP_IPv6_PREFIX_FILTER"
  type = string
}

variable "route_filter_policy_description" {
  description = "Description of the route filter policy you're creating"
  type = string
  default = ""
}

variable "route_filter_rules" {
  description = "List of route filter rules to add to the created route filter policy"
  type        = list(object({
    prefix = string,
    name = optional(string),
    description = optional(string),
    prefix_match = optional(string),
  }))
}

variable "connection_route_filter_direction" {
  description = "Direction [INBOUND or OUTBOUND] that the route filter policy is applied to for the connection"
  type = string
}

variable "connection_id" {
  description = "Id of the Fabric connection you want to attach the route filter policy to"
  type = string
}
```

 #outputs.tf
```hcl

```

 #main.tf
```hcl
resource "equinix_fabric_route_filter" "policy" {
  name = var.route_filter_policy_name
  project {
    project_id = var.route_filter_policy_project_id
  }
  type = var.route_filter_policy_type
  description = var.route_filter_policy_description != "" ? var.route_filter_policy_description : null
}

resource "equinix_fabric_route_filter_rule" "this" {
  for_each = {
    for index, rule in var.route_filter_rules:
        rule.prefix => rule
  }
  route_filter_id = equinix_fabric_route_filter.policy.id
  name = each.value.name != "" ? each.value.name : null
  description = each.value.description != "" ? each.value.description : null
  prefix = each.value.prefix
  prefix_match = each.value.prefix_match != "" ? each.value.prefix_match : null
}


resource "equinix_fabric_connection_route_filter" "attachment" {
  depends_on = [ equinix_fabric_route_filter_rule.this ]
  connection_id = var.connection_id
  route_filter_id = equinix_fabric_route_filter.policy.id
  direction = var.connection_route_filter_direction
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
| [equinix_fabric_connection_route_filter.attachment](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection_route_filter) | resource |
| [equinix_fabric_route_filter.policy](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_route_filter) | resource |
| [equinix_fabric_route_filter_rule.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_route_filter_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | Id of the Fabric connection you want to attach the route filter policy to | `string` | n/a | yes |
| <a name="input_connection_route_filter_direction"></a> [connection\_route\_filter\_direction](#input\_connection\_route\_filter\_direction) | Direction [INBOUND or OUTBOUND] that the route filter policy is applied to for the connection | `string` | n/a | yes |
| <a name="input_route_filter_policy_description"></a> [route\_filter\_policy\_description](#input\_route\_filter\_policy\_description) | Description of the route filter policy you're creating | `string` | `""` | no |
| <a name="input_route_filter_policy_name"></a> [route\_filter\_policy\_name](#input\_route\_filter\_policy\_name) | Name of the route filter policy that will be created in this module | `string` | n/a | yes |
| <a name="input_route_filter_policy_project_id"></a> [route\_filter\_policy\_project\_id](#input\_route\_filter\_policy\_project\_id) | Project id where the route filter policy will be created. Should match the project id of the connection you would like to attach the route filter policy to | `string` | n/a | yes |
| <a name="input_route_filter_policy_type"></a> [route\_filter\_policy\_type](#input\_route\_filter\_policy\_type) | Type of the route filter policy. Should be one of: BGP\_IPv4\_PREFIX\_FILTER, BGP\_IPv6\_PREFIX\_FILTER | `string` | n/a | yes |
| <a name="input_route_filter_rules"></a> [route\_filter\_rules](#input\_route\_filter\_rules) | List of route filter rules to add to the created route filter policy | <pre>list(object({<br>    prefix = string,<br>    name = optional(string),<br>    description = optional(string),<br>    prefix_match = optional(string),<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->