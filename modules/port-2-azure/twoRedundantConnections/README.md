# ECX Fabric Layer2 Redundant Connection to Azure

This example shows how to create Layer 2 Connection between two ECX Fabric ports
and AZURE Cloud.

## Adjust variables

At minimum, you must set below variables in `terraform.tfvars` file:

* `equinix_client_id` - Equinix client ID (consumer key), obtained after
  registering app in the developer platform
* `equinix_client_secret` - Equinix client secret ID (consumer secret),
  obtained same way as above

`pri_connection_name` - The name of the PRIMARY connection
`sec_connection_name` - The name of the SECONDARY connection
`connection_type` - Connection type, please refer to OAS schema for enum values.
`notifications_type` - Notification type
`notifications_emails` - List of emails
`bandwidth` - Bandwidth in MBs
`purchase_order_number` - Purchase order number applied to billing invoices for this connection.
`aside_ap_type` - Access point type
`aside_link_protocol_type` - Link protocol type
`aside_pri_link_protocol_stag` - S-Tag number for PRIMARY Connection
`aside_sec_link_protocol_stag` - S-Tag number for SECONDARY Connection
`zside_ap_type` - Z side access point type
`zside_ap_authentication_key` - AZURE authorization key, like c620477c-3f30-41e8-a0b9-cf324a12121d
`zside_ap_profile_type` - Service profile type
`zside_location` - Equinix Metro Code for the Z side access point
`fabric_sp_name` - Service profile name like i.e. AZURE
`equinix_pri_port_name` -  Name of ECX Fabric Port for the PRIMARY Connection
`equinix_sec_port_name` - Name of ECX Fabric Port for the SECONDARY Connection

## Azure login

Log in to Azure portal with an account that has permission to create necessary resources.

Create an Azure ExpressRoute Circuit and use its Service Key as the Authentication Key in the examples.

Bandwidth in Terraform must match the bandwidth of the ExpressRoute Circuit created in Azure.

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations for port2azure redundant connections can be found at examples/fabric/v4/portConnectivity/azure/twoRedundantConnections.

- Change directory into - `CD examples/fabric/v4/portConnectivity/azure/twoRedundantConnections`
- Initialize Terraform plugins - `terraform init`

## Port to Azure connection  : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                               Description |
|:----------|:---------------------------------:|--------------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                       Creates a port2azure redundant connection resources |
| READ      |         `terraform show`          |      Reads/Shows the current state of the port2azure connection resources |
| UPDATE    |    `terraform apply -refresh`     | Updates the connections with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                       Deletes the created port2azure connection resources |


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
| [equinix_fabric_connection.azure-qinq](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.azure-qinq-second-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.qinq-pri](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_ports.qinq-sec](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_service_profiles.azure](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_aside_link_protocol_type"></a> [aside\_link\_protocol\_type](#input\_aside\_link\_protocol\_type) | n/a | `any` | n/a | yes |
| <a name="input_aside_pri_link_protocol_stag"></a> [aside\_pri\_link\_protocol\_stag](#input\_aside\_pri\_link\_protocol\_stag) | n/a | `any` | n/a | yes |
| <a name="input_aside_sec_link_protocol_stag"></a> [aside\_sec\_link\_protocol\_stag](#input\_aside\_sec\_link\_protocol\_stag) | n/a | `any` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_equinix_pri_port_name"></a> [equinix\_pri\_port\_name](#input\_equinix\_pri\_port\_name) | n/a | `any` | n/a | yes |
| <a name="input_equinix_sec_port_name"></a> [equinix\_sec\_port\_name](#input\_equinix\_sec\_port\_name) | n/a | `any` | n/a | yes |
| <a name="input_fabric_sp_name"></a> [fabric\_sp\_name](#input\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_pri_connection_name"></a> [pri\_connection\_name](#input\_pri\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_sec_connection_name"></a> [sec\_connection\_name](#input\_sec\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_result"></a> [connection\_result](#output\_connection\_result) | n/a |
| <a name="output_second_connection_result"></a> [second\_connection\_result](#output\_second\_connection\_result) | n/a |
<!-- END_TF_DOCS -->