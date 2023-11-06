# ECX Fabric Layer2 Single Connection from fabric cloud router to Service Profile

This example shows how create single connection from Fabric Cloud Router to Seller Service Profile, on ECX Fabric ports.

## Adjust variables
At minimum, you must set below variables in `terraform.tfvars` file:

- `equinix_client_id` - Equinix client ID (consumer key), obtained after registering app in the developer platform
- `equinix_client_secret` - Equinix client secret ID (consumer secret), obtained same way as above
- `fcr_uuid` - UUID of ECX Fabric Cloud Router on a-sideshow
- `connection_name` - the name of the connection
- `connection_type` - connection type, please refer schema
- `notifications_type` - notification type
- `notifications_emails` - List of emails
- `bandwidth` - bandwidth in MBs
- `redundancy` - Port redundancy
- `aside_ap_type` - Fabric Cloud Router type
- `zside_ap_type` - Z side access point type
- `zside_ap_profile_type` - Service profile type
- `fabric_sp_name` - Service profile name, fetched based on Service Profile get call using Service Profile search schema
- `zside_location` - Seller location

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations on a fcr2serviceprofile connection can be found at examples/fabric/v4/cloudRouterConnectivity/cloudRouter2serviceprofile.

- Change directory into - `CD cloudRouter2serviceprofile`
- Initialize Terraform plugins - `terraform init`

## Fabric Cloud Router to ServiceProfile connection : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                                      Description |
|:----------|:---------------------------------:|---------------------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                                 Creates a fcr2serviceprofile connection resource |
| READ      |         `terraform show`          |      Reads/Shows the current state of the fcr2serviceprofile connection resource |
| UPDATE    |    `terraform apply -refresh`     | Updates the fcr2serviceprofile with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                       Deletes the created fcr2serviceprofile connection resource |
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
| [equinix_fabric_connection.fcr2profile](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_service_profiles.sp](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_fabric_sp_name"></a> [fabric\_sp\_name](#input\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_fcr_uuid"></a> [fcr\_uuid](#input\_fcr\_uuid) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_redundancy"></a> [redundancy](#input\_redundancy) | n/a | `any` | n/a | yes |
| <a name="input_redundancy_group_uuid"></a> [redundancy\_group\_uuid](#input\_redundancy\_group\_uuid) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_result"></a> [connection\_result](#output\_connection\_result) | n/a |
<!-- END_TF_DOCS -->