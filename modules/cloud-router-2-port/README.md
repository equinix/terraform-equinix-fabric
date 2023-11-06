# ECX Fabric Layer2 Connection from fabric cloud router to port

This example shows how create connection from Fabric Cloud Router to port, on ECX Fabric ports.

## Adjust variables
At minimum, you must set below variables in `terraform.tfvars` file:

- `equinix_client_id` - Equinix client ID (consumer key), obtained after registering app in the developer platform
- `equinix_client_secret` - Equinix client secret ID (consumer secret), obtained same way as above
- `fcr_uuid` - UUID of ECX Fabric Cloud Router on a-side 
- `zside_port_name` -  Name of ECX Fabric z-side port , i.e. ops-user100-CX-SV5-NL-Qinq-BO-10G-SEC-JP-000
- `connection_name` - the name of the connection
- `connection_type` - connection type, please refer schema
- `notifications_type` - notification type
- `notifications_emails` - List of emails
- `bandwidth` - bandwidth in MBs
- `redundancy` - Port redundancy
- `aside_ap_type` - Fabric Cloud Router type
- `zside_ap_type` - Z side access point type
- `zside_link_protocol_tag` - z-side vlan tag number
- `zside_location` - Seller location

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations on a fcr2port connection can be found at examples/fcr2port/.

- Change directory into - `CD examples/fcr2port/`
- Initialize Terraform plugins - `terraform init`

## Fabric Cloud Router to port connection : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                            Description |
|:----------|:---------------------------------:|-----------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                                 Creates a fcr2port connection resource |
| READ      |         `terraform show`          |      Reads/Shows the current state of the fcr2port connection resource |
| UPDATE    |    `terraform apply -refresh`     | Updates the fcr2port with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                       Deletes the created fcr2port connection resource |
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
| [equinix_fabric_connection.fcr2port](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_fcr_uuid"></a> [fcr\_uuid](#input\_fcr\_uuid) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_redundancy"></a> [redundancy](#input\_redundancy) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_link_protocol_tag"></a> [zside\_link\_protocol\_tag](#input\_zside\_link\_protocol\_tag) | n/a | `any` | n/a | yes |
| <a name="input_zside_link_protocol_type"></a> [zside\_link\_protocol\_type](#input\_zside\_link\_protocol\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `any` | n/a | yes |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_result"></a> [connection\_result](#output\_connection\_result) | n/a |
<!-- END_TF_DOCS -->