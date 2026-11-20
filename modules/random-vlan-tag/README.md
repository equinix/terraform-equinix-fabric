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
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}
```

#variables.tf
 ```hcl
variable "min" {
  description = "Minimum VLAN tag value"
  type        = number
  default     = 100
}

variable "max" {
  description = "Maximum VLAN tag value"
  type        = number
  default     = 2500
}
```

 #outputs.tf
```hcl
output "result" {
  description = "Generated random VLAN tag"
  value       = random_integer.vlan_tag.result
}

output "result_string" {
  description = "Generated random VLAN tag as string"
  value       = tostring(random_integer.vlan_tag.result)
}
```

 #main.tf
```hcl
resource "random_integer" "vlan_tag" {
  min = var.min
  max = var.max
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_integer.vlan_tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max"></a> [max](#input\_max) | Maximum VLAN tag value | `number` | `2500` | no |
| <a name="input_min"></a> [min](#input\_min) | Minimum VLAN tag value | `number` | `100` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | Generated random VLAN tag |
| <a name="output_result_string"></a> [result\_string](#output\_result\_string) | Generated random VLAN tag as string |
<!-- END_TF_DOCS -->