# Fabric Routing Aggregation SubModule

The Fabric Route Aggregation Module will create a Route Aggregation Policy, add Route Aggregation Rules to it,
and attach the Route Aggregation Policy to an existing Fabric Connection.

Please refer to the cloud-router-2-port-connection-with-route-aggregations example in this module's
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
      source="equinix/equinix"
      version = "3.3.0"
    }
  }
}
```

#variables.tf
 ```hcl
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

variable "route_aggregation_project_id" {
  description = "Project id where the route aggregation policy will be created. Should match the project id of the connection you would like to attach the route aggregation policy to"
  type        = string
}
variable "route_aggregation_rules" {
  description = "List of route aggregation rules to add to the created route aggregation policy"
  type        = list(object({
    prefix = string,
    name = optional(string),
    description = optional(string),
  }))
}

variable "connection_id" {
  description = "Id of the Fabric connection you want to attach the route filter policy to"
  type        = string
}
```

 #outputs.tf
```hcl
output "route_aggregation" {
  value = equinix_fabric_route_aggregation.route-aggregation
}

output "route_aggregation_rule" {
  value = equinix_fabric_route_aggregation_rule.ra_rule
}

output "connection_route_aggregation" {
  value = equinix_fabric_connection_route_aggregation.attachment
}
```

 #main.tf
```hcl
resource "equinix_fabric_route_aggregation" "route-aggregation" {
  type        = var.route_aggregation_type
  name        = var.route_aggregation_name
  description = var.route_aggregation_description
  project = {
    project_id = var.route_aggregation_project_id
  }
}

resource "equinix_fabric_route_aggregation_rule" "ra_rule" {
  for_each = {
    for index, rule in var.route_aggregation_rules:
    rule.prefix => rule
  }
  route_aggregation_id  = equinix_fabric_route_aggregation.route-aggregation.id
  name                  = each.value.name != "" ? each.value.name : null
  description = each.value.description != "" ? each.value.description : null
  prefix = each.value.prefix
}

resource "equinix_fabric_connection_route_aggregation" "attachment" {
  route_aggregation_id  = equinix_fabric_route_aggregation.route-aggregation.id
  connection_id         = var.connection_id
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

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection_route_aggregation.attachment](https://registry.terraform.io/providers/equinix/equinix/3.3.0/docs/resources/fabric_connection_route_aggregation) | resource |
| [equinix_fabric_route_aggregation.route-aggregation](https://registry.terraform.io/providers/equinix/equinix/3.3.0/docs/resources/fabric_route_aggregation) | resource |
| [equinix_fabric_route_aggregation_rule.ra_rule](https://registry.terraform.io/providers/equinix/equinix/3.3.0/docs/resources/fabric_route_aggregation_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_id"></a> [connection\_id](#input\_connection\_id) | Id of the Fabric connection you want to attach the route filter policy to | `string` | n/a | yes |
| <a name="input_route_aggregation_description"></a> [route\_aggregation\_description](#input\_route\_aggregation\_description) | Description of the route aggregation policy you're creating | `string` | `""` | no |
| <a name="input_route_aggregation_name"></a> [route\_aggregation\_name](#input\_route\_aggregation\_name) | Name of the route aggregation policy that will be created in this module | `string` | n/a | yes |
| <a name="input_route_aggregation_project_id"></a> [route\_aggregation\_project\_id](#input\_route\_aggregation\_project\_id) | Project id where the route aggregation policy will be created. Should match the project id of the connection you would like to attach the route aggregation policy to | `string` | n/a | yes |
| <a name="input_route_aggregation_rules"></a> [route\_aggregation\_rules](#input\_route\_aggregation\_rules) | List of route aggregation rules to add to the created route aggregation policy | <pre>list(object({<br>    prefix = string,<br>    name = optional(string),<br>    description = optional(string),<br>  }))</pre> | n/a | yes |
| <a name="input_route_aggregation_type"></a> [route\_aggregation\_type](#input\_route\_aggregation\_type) | Type of the route aggregation policy. Should be one of: BGP\_IPv4\_PREFIX\_ROUTE\_AGGREGATION | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_route_aggregation"></a> [connection\_route\_aggregation](#output\_connection\_route\_aggregation) | n/a |
| <a name="output_route_aggregation"></a> [route\_aggregation](#output\_route\_aggregation) | n/a |
| <a name="output_route_aggregation_rule"></a> [route\_aggregation\_rule](#output\_route\_aggregation\_rule) | n/a |
<!-- END_TF_DOCS -->
