<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_cloud_router.test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_cloud_router) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Account number | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_fcr_location"></a> [fcr\_location](#input\_fcr\_location) | Fabric Cloud Router Location | `string` | n/a | yes |
| <a name="input_fcr_name"></a> [fcr\_name](#input\_fcr\_name) | Fabric Cloud Router Name | `string` | n/a | yes |
| <a name="input_fcr_package"></a> [fcr\_package](#input\_fcr\_package) | Fabric Cloud Router Package like LAB, ADVANCED, STANDARD, PREMIUM | `string` | n/a | yes |
| <a name="input_fcr_type"></a> [fcr\_type](#input\_fcr\_type) | Fabric Cloud Router Type like XF\_ROUTER | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Subscriber-assigned project ID | `string` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_router_id"></a> [cloud\_router\_id](#output\_cloud\_router\_id) | n/a |
<!-- END_TF_DOCS -->