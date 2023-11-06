# ECX Fabric Layer2 Two Redundant Connections from fabric cloud router to Azure

This example shows how create two redundant connections from Fabric Cloud Router to Azure, on ECX Fabric ports.

## Adjust variables
At minimum, you must set below variables in `terraform.tfvars` file:

- `equinix_client_id` - Equinix client ID (consumer key), obtained after registering app in the developer platform
- `equinix_client_secret` - Equinix client secret ID (consumer secret), obtained same way as above
- `pri_connection_name` - the name of the primary connection
- `sec_connection_name` - the name of the secondary connection
- `connection_type` - connection type, please refer schema
- `notifications_type` - notification type
- `notifications_emails` - List of emails
- `bandwidth` - bandwidth in MBs
- `aside_ap_type` - Fabric Cloud Router type
- `peering_type` - Peering type for the ECX Fabric Cloud Router on the a-side; typically PRIVATE
**Note: You can use one Cloud Router for both connections if you would like**
- `cloud_router_primary_uuid` - UUID of ECX Fabric Cloud Router on a-side
- `cloud_router_secondary_uuid` - UUID of ECX Fabric Cloud Router on a-side for secondary connection
- `zside_ap_type` - Z side access point type
- `zside_ap_authentication_key` - Azure authorization key, service key generated from Azure Portal
- `zside_ap_profile_type` - Service profile type
- `zside_ap_profile_uuid` - Service profile UUID
- `zside_location` - Seller location
- `fabric_sp_name` - Service profile name, fetched based on Service Profile get call using Service Profile search schema

## Azure login

Log in to Azure portal use account that has permission to create necessary resources.

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations on a fcr2azure connection can be found at examples/fabric/v4/cloudRouterConnectivity/cloudRouter2azure/two-connections/.

- Change directory into - `CD examples/fabric/v4/cloudRouterConnectivity/cloudRouter2azure/two-connections/`
- Initialize Terraform plugins - `terraform init`

## Fabric Cloud Router to Azure Two connections : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                             Description |
|:----------|:---------------------------------:|------------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                      Creates a fcr2azure redundant connection resources |
| READ      |         `terraform show`          |     Reads/Shows the current state of the fcr2azure connection resources |
| UPDATE    |    `terraform apply -refresh`     | Updates the fcr2azure with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                      Deletes the created fcr2azure connection resources |
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection.fcr2azure](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.fcr2azure2](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_service_profiles.azure](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_cloud_router_primary_uuid"></a> [cloud\_router\_primary\_uuid](#input\_cloud\_router\_primary\_uuid) | n/a | `any` | n/a | yes |
| <a name="input_cloud_router_secondary_uuid"></a> [cloud\_router\_secondary\_uuid](#input\_cloud\_router\_secondary\_uuid) | n/a | `any` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_fabric_sp_name"></a> [fabric\_sp\_name](#input\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_peering_type"></a> [peering\_type](#input\_peering\_type) | n/a | `any` | n/a | yes |
| <a name="input_pri_connection_name"></a> [pri\_connection\_name](#input\_pri\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_pri_purchase_order_number"></a> [pri\_purchase\_order\_number](#input\_pri\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_sec_connection_name"></a> [sec\_connection\_name](#input\_sec\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_sec_purchase_order_number"></a> [sec\_purchase\_order\_number](#input\_sec\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_connection_result"></a> [primary\_connection\_result](#output\_primary\_connection\_result) | n/a |
| <a name="output_secondary_connection_result"></a> [secondary\_connection\_result](#output\_secondary\_connection\_result) | n/a |
<!-- END_TF_DOCS -->