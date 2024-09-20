# Fabric Cloud Router Creation with Market Place Subscription

This example shows how to create a Fabric Cloud Router using Market Place Subscription, which can be generated through various Cloud Service Providers.

It leverages the Equinix Terraform Provider to setup the Fabric Cloud Router based on the parameters you have provided to this example; or based on the pattern
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
cd terraform-equinix-fabric/examples/cloud-router-marketplace-susbscription
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):
```hcl
equinix_client_id     = "<MyEquinixClientId>"
equinix_client_secret = "<MyEquinixSecret>"

fcr_location                  = "SV"
fcr_name                      = "terra_fcr_marketplace"
fcr_package                   = "ADVANCED"
fcr_type                      = "XF_ROUTER"
notifications_emails          = ["diginpanthers@gmail.com"]
notifications_type            = "ALL"
project_id                    = "<Project_Id>"
purchase_order_number         = "1-323292"

marketplace_subscription_type = "AWS_MARKETPLACE_SUBSCRIPTION",
marketplace_subscription_uuid = "<Marketplace_Subscription_Id>"
```

versions.tf
```hcl
terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.5.0"
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
variable "fcr_name" {
  description = "Fabric Cloud Router Name"
  type        = string
}
variable "fcr_type" {
  description = "Fabric Cloud Router Type like XF_ROUTER"
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
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
}
variable "fcr_location" {
  description = "Fabric Cloud Router Location"
  type        = string
}
variable "fcr_package" {
  description = "Fabric Cloud Router Package like LAB, ADVANCED, STANDARD, PREMIUM"
  type        = string
}
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
}
variable "marketplace_subscription_type" {
  description = "Marketplace subscription type"
  type        = string
}
variable "marketplace_subscription_uuid" {
  description = "Marketplace subscription UUID"
  type        = string
  sensitive   = true
}
```

outputs.tf
```hcl
output "cloud_router_id" {
  value = equinix_fabric_cloud_router.create_fcr_marketplace_subscription.id
}
```

main.tf
```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

data "equinix_fabric_market_place_subscription" "subscription" {
  uuid = var.marketplace_subscription_uuid
}

locals {
  entitlement = flatten([
    for entitlement in data.equinix_fabric_market_place_subscription.subscription.entitlements : [
      for asset in entitlement.asset : asset.package
    ]
  ])
}

resource "equinix_fabric_cloud_router" "create_fcr_marketplace_subscription"{
  name = var.fcr_name
  type = var.fcr_type
  notifications{
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  order {
    purchase_order_number = var.purchase_order_number
  }
  location {
    metro_code = var.fcr_location
  }
  package {
    code = local.entitlement[1].code
  }
  project {
    project_id = var.project_id
  }
  marketplace_subscription{
    type = var.marketplace_subscription_type
    uuid = data.equinix_fabric_market_place_subscription.subscription.uuid
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 2.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 2.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_cloud_router.create_fcr_marketplace_subscription](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_cloud_router) | resource |
| [equinix_fabric_market_place_subscription.subscription](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_market_place_subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_fcr_location"></a> [fcr\_location](#input\_fcr\_location) | Fabric Cloud Router Location | `string` | n/a | yes |
| <a name="input_fcr_name"></a> [fcr\_name](#input\_fcr\_name) | Fabric Cloud Router Name | `string` | n/a | yes |
| <a name="input_fcr_package"></a> [fcr\_package](#input\_fcr\_package) | Fabric Cloud Router Package like LAB, ADVANCED, STANDARD, PREMIUM | `string` | n/a | yes |
| <a name="input_fcr_type"></a> [fcr\_type](#input\_fcr\_type) | Fabric Cloud Router Type like XF\_ROUTER | `string` | n/a | yes |
| <a name="input_marketplace_subscription_type"></a> [marketplace\_subscription\_type](#input\_marketplace\_subscription\_type) | Marketplace subscription type | `string` | n/a | yes |
| <a name="input_marketplace_subscription_uuid"></a> [marketplace\_subscription\_uuid](#input\_marketplace\_subscription\_uuid) | Marketplace subscription UUID | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_router_id"></a> [cloud\_router\_id](#output\_cloud\_router\_id) | n/a |
<!-- END_TF_DOCS -->
