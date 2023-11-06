# ECX Fabric Layer2 private seller profile

This example shows how to create layer2 between ECX Fabric Port and Private Seller Profile.

## Adjust variables
- `equinix_client_id` - Equinix client ID (consumer key), obtained after registering app in the developer platform
- `equinix_client_secret` - Equinix client secret ID (consumer secret), obtained same way as above
- `fabric_sp_name` - Service profile name like i.e. **Equinix Direct Connect - Private**
- `aside_port_name` -  Name of ECX Fabric port that should be connected used for the connection, i.e. ops-user100-CX-SV5-NL-Qinq-BO-10G-SEC-JP-000
- `connection_name` - the name of the connection
- `connection_type` - connection type, please refer schema
- `notifications_type` - notification type
- `notifications_emails` - List of emails
- `bandwidth` - bandwidth in MBs
- `redundancy` - Port redundancy
- `aside_ap_type` - Access point type
- `aside_port_uuid` - Port uuid, fetched based on port call using Port resource
- `aside_link_protocol_type` - link protocol type
- `aside_link_protocol_tag` - tag number
- `zside_ap_type` - Z side access point type
- `zside_ap_profile_type` - Service profile type
- `zside_ap_profile_uuid` - Service profile uuid, fetched based on Service Profile get call using Service Profile search schema
- `zside_location` - Seller location

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations for port2serviceprofileprivate connection can be found at examples/fabric/v4/portConnectivity/port2serviceprofileprivate/.

- Change directory into - `CD examples/fabric/v4/portConnectivity/port2serviceprofileprivate/`
- Initialize Terraform plugins - `terraform init`

## Port to Service Profile Private connection  : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                                              Description |
|:----------|:---------------------------------:|-----------------------------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                                 Creates a port2serviceprofileprivate connection resource |
| READ      |         `terraform show`          |      Reads/Shows the current state of the port2serviceprofileprivate connection resource |
| UPDATE    |    `terraform apply -refresh`     | Updates the port2serviceprofileprivate with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                       Deletes the created port2serviceprofileprivate connection resource |
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
| [equinix_fabric_connection.sp-private-qinq](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.aside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_ports.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_service_profiles.spprivate](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_aside_link_protocol_tag"></a> [aside\_link\_protocol\_tag](#input\_aside\_link\_protocol\_tag) | n/a | `any` | n/a | yes |
| <a name="input_aside_link_protocol_type"></a> [aside\_link\_protocol\_type](#input\_aside\_link\_protocol\_type) | n/a | `any` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_equinix_aside_port_name"></a> [equinix\_aside\_port\_name](#input\_equinix\_aside\_port\_name) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_equinix_zside_port_name"></a> [equinix\_zside\_port\_name](#input\_equinix\_zside\_port\_name) | n/a | `any` | n/a | yes |
| <a name="input_fabric_sp_name"></a> [fabric\_sp\_name](#input\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_redundancy"></a> [redundancy](#input\_redundancy) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_link_protocol_tag"></a> [zside\_link\_protocol\_tag](#input\_zside\_link\_protocol\_tag) | n/a | `any` | n/a | yes |
| <a name="input_zside_link_protocol_type"></a> [zside\_link\_protocol\_type](#input\_zside\_link\_protocol\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_result"></a> [connection\_result](#output\_connection\_result) | n/a |
<!-- END_TF_DOCS -->