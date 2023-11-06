# ECX Fabric Layer2 MultiCloud Connection: FCR 2 AWS and Azure

This example shows how to create Layer 2 Connection between FCR to AWS and Azure.

## Adjust variables

At minimum, you must set below variables in `terraform.tfvars` file:

* `equinix_client_id` - Equinix client ID (consumer key), obtained after
  registering app in the developer platform
* `equinix_client_secret` - Equinix client secret ID (consumer secret),
  obtained same way as above

`fcr_name` - Name of ECX Fabric Cloud Router on a-side , i.e. amcrh007-fcr
`fcr_type` - Fabric Cloud Router type
`fcr_location` - Fabric Cloud Router location
`fcr_project` - Fabric Cloud Router project
`fcr_account` - Fabric Cloud Router account
`fcr_package` - Fabric Cloud Router package type, i.e. PRO
`notifications_type` - notification type
`notifications_emails` - List of emails


`azure_connection_name` - The name of the Azure connection
`azure_connection_type` - Connection type, please refer to OAS schema for enum values.
`azure_notifications_type` - Notification type
`azure_notifications_emails` - List of emails
`azure_bandwidth` - Bandwidth in MBs
`azure_redundancy` - Port redundancy PRIMARY or SECONDARY
`azure_purchase_order_number` - Purchase order number applied to billing invoices for this connection.
`azure_peering_type` - Peering Type
`azure_aside_ap_type` - Access point type

`azure_zside_ap_type` - Z side access point type
`azure_zside_ap_authentication_key` - AZURE authorization key, like c620477c-3f30-41e8-a0b9-cf324a12121d
`azure_zside_ap_profile_type` - Service profile type
`azure_zside_location` - Equinix Metro Code for the Z side access point
`azure_fabric_sp_name` - Service profile name like i.e. AZURE

`azure_rp_name`- Name of Direct routing Protocol
`azure_rp_type`- Type of Direct routing Protocol entity, "DIRECT"
`azure_equinix_ipv4_ip` = Equinix Side IpV4 Address
`azure_equinix_ipv6_ip` = Equinix Side IpV6 Address

`azure_bgp_rp_name` - Name of BGP routing Protocol
`azure_bgp_rp_type` - Type of BGP routing Protocol entity, "BGP"
`azure_bgp_customer_peer_ipv4` - Customer Side IpV4 Address
`azure_bgp_customer_peer_ipv6` - Customer Side IpV6 Address
`azure_bgp_enabled_ipv4` - Enable BGP IpV4 session from customer side
`azure_bgp_enabled_ipv6` - Enable BGP IpV6 session from customer side
`azure_bgp_customer_asn` - Customer ASN Number

`aws_connection_name` - The name of the AWS connection
`aws_connection_type` - connection type, please refer schema
`aws_notifications_type` - notification type
`aws_notifications_emails` - List of emails
`aws_bandwidth` - bandwidth in MBs
`aws_redundancy` - Port redundancy
`aws_aside_ap_type` - Fabric Cloud Router type
`aws_zside_ap_type` - Z side access point type
`aws_zside_ap_authentication_key` - AWS authorization key, account number like 357848912121
`aws_access_key` - AWS access key, like BQR12AHQKSYUTPBGHPIJ
`aws_secret_key` - AWS secret key, like 2qwrbYTUUIQWOOEIHDJSKbhikjhalpe
`aws_zside_ap_profile_type` - Service profile type
`aws_fabric_sp_name` - Service profile name, fetched based on Service Profile get call using Service Profile search schema
`aws_zside_location` - Seller location
`aws_seller_region` - Seller region code

`aws_rp_name`- Name of Direct routing Protocol
`aws_rp_type`- Type of Direct routing Protocol entity, "DIRECT"
`aws_equinix_ipv4_ip` = Equinix Side IpV4 Address
`aws_equinix_ipv6_ip` = Equinix Side IpV6 Address

`aws_bgp_rp_name` - Name of BGP routing Protocol
`aws_bgp_rp_type` - Type of BGP routing Protocol entity, "BGP"
`aws_bgp_customer_peer_ipv4` - Customer Side IpV4 Address
`aws_bgp_customer_peer_ipv6` - Customer Side IpV6 Address
`aws_bgp_enabled_ipv4` - Enable BGP IpV4 session from customer side
`aws_bgp_enabled_ipv6` - Enable BGP IpV6 session from customer side
`aws_bgp_customer_asn` - Customer ASN Number

## Azure login

Log in to Azure portal with an account that has permission to create necessary resources.

Create an Azure ExpressRoute Circuit and use its Service Key as the Authentication Key in the examples.

Bandwidth in Terraform must match the bandwidth of the ExpressRoute Circuit created in Azure.

## AWS login

Log in to AWS portal use account that has permission to create necessary resources.

## Initialize
- First step is to initialize the terraform directory/resource we are going to work on.
  In the given example, the folder to perform CRUD operations for multi cloud connections can be found at examples/fabric/v4/cloudRouterConnectivity/MutliCloudConnection

- Change directory into - `CD examples/fabric/v4/cloudRouterConnectivity/MutliCloudConnection`
- Initialize Terraform plugins - `terraform init`

## Multi Cloud connection  : Create, Read, Update and Delete(CRUD) operations
Note: `–auto-approve` command does not prompt the user for validating the applying config. Remove it to get a prompt to confirm the operation.

| Operation |              Command              |                                                               Description |
|:----------|:---------------------------------:|--------------------------------------------------------------------------:|
| CREATE    |  `terraform apply –auto-approve`  |                                  Creates multi-cloud connection resources |
| READ      |         `terraform show`          |      Reads/Shows the current state of the multi-cloud connection resources |
| UPDATE    |    `terraform apply -refresh`     | Updates the connections with values provided in the terraform.tfvars file |
| DELETE    | `terraform destroy –auto-approve` |                       Deletes the created multi-cloud connection resources |

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
| [equinix_fabric_cloud_router.test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_cloud_router) | resource |
| [equinix_fabric_connection.fcr2aws](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.fcr2azure](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_routing_protocol.aws-bgp-protocol](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |
| [equinix_fabric_routing_protocol.aws-direct-protocol](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |
| [equinix_fabric_routing_protocol.azure-bgp-protocol](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |
| [equinix_fabric_routing_protocol.azure-direct-protocol](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_routing_protocol) | resource |
| [equinix_fabric_service_profiles.aws](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |
| [equinix_fabric_service_profiles.azure](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | n/a | `any` | n/a | yes |
| <a name="input_aws_aside_ap_type"></a> [aws\_aside\_ap\_type](#input\_aws\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_bandwidth"></a> [aws\_bandwidth](#input\_aws\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_customer_asn"></a> [aws\_bgp\_customer\_asn](#input\_aws\_bgp\_customer\_asn) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_customer_peer_ipv4"></a> [aws\_bgp\_customer\_peer\_ipv4](#input\_aws\_bgp\_customer\_peer\_ipv4) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_customer_peer_ipv6"></a> [aws\_bgp\_customer\_peer\_ipv6](#input\_aws\_bgp\_customer\_peer\_ipv6) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_enabled_ipv4"></a> [aws\_bgp\_enabled\_ipv4](#input\_aws\_bgp\_enabled\_ipv4) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_enabled_ipv6"></a> [aws\_bgp\_enabled\_ipv6](#input\_aws\_bgp\_enabled\_ipv6) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_rp_name"></a> [aws\_bgp\_rp\_name](#input\_aws\_bgp\_rp\_name) | n/a | `any` | n/a | yes |
| <a name="input_aws_bgp_rp_type"></a> [aws\_bgp\_rp\_type](#input\_aws\_bgp\_rp\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_connection_name"></a> [aws\_connection\_name](#input\_aws\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_aws_connection_type"></a> [aws\_connection\_type](#input\_aws\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_equinix_ipv4_ip"></a> [aws\_equinix\_ipv4\_ip](#input\_aws\_equinix\_ipv4\_ip) | n/a | `any` | n/a | yes |
| <a name="input_aws_equinix_ipv6_ip"></a> [aws\_equinix\_ipv6\_ip](#input\_aws\_equinix\_ipv6\_ip) | n/a | `any` | n/a | yes |
| <a name="input_aws_fabric_sp_name"></a> [aws\_fabric\_sp\_name](#input\_aws\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_aws_notifications_emails"></a> [aws\_notifications\_emails](#input\_aws\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_aws_notifications_type"></a> [aws\_notifications\_type](#input\_aws\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_purchase_order_number"></a> [aws\_purchase\_order\_number](#input\_aws\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_aws_redundancy"></a> [aws\_redundancy](#input\_aws\_redundancy) | n/a | `any` | n/a | yes |
| <a name="input_aws_rp_name"></a> [aws\_rp\_name](#input\_aws\_rp\_name) | n/a | `any` | n/a | yes |
| <a name="input_aws_rp_type"></a> [aws\_rp\_type](#input\_aws\_rp\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | n/a | `any` | n/a | yes |
| <a name="input_aws_seller_region"></a> [aws\_seller\_region](#input\_aws\_seller\_region) | n/a | `any` | n/a | yes |
| <a name="input_aws_zside_ap_authentication_key"></a> [aws\_zside\_ap\_authentication\_key](#input\_aws\_zside\_ap\_authentication\_key) | n/a | `any` | n/a | yes |
| <a name="input_aws_zside_ap_profile_type"></a> [aws\_zside\_ap\_profile\_type](#input\_aws\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_zside_ap_type"></a> [aws\_zside\_ap\_type](#input\_aws\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_zside_location"></a> [aws\_zside\_location](#input\_aws\_zside\_location) | n/a | `any` | n/a | yes |
| <a name="input_azure_aside_ap_type"></a> [azure\_aside\_ap\_type](#input\_azure\_aside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_bandwidth"></a> [azure\_bandwidth](#input\_azure\_bandwidth) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_customer_asn"></a> [azure\_bgp\_customer\_asn](#input\_azure\_bgp\_customer\_asn) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_customer_peer_ipv4"></a> [azure\_bgp\_customer\_peer\_ipv4](#input\_azure\_bgp\_customer\_peer\_ipv4) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_customer_peer_ipv6"></a> [azure\_bgp\_customer\_peer\_ipv6](#input\_azure\_bgp\_customer\_peer\_ipv6) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_enabled_ipv4"></a> [azure\_bgp\_enabled\_ipv4](#input\_azure\_bgp\_enabled\_ipv4) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_enabled_ipv6"></a> [azure\_bgp\_enabled\_ipv6](#input\_azure\_bgp\_enabled\_ipv6) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_rp_name"></a> [azure\_bgp\_rp\_name](#input\_azure\_bgp\_rp\_name) | n/a | `any` | n/a | yes |
| <a name="input_azure_bgp_rp_type"></a> [azure\_bgp\_rp\_type](#input\_azure\_bgp\_rp\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_connection_name"></a> [azure\_connection\_name](#input\_azure\_connection\_name) | n/a | `any` | n/a | yes |
| <a name="input_azure_connection_type"></a> [azure\_connection\_type](#input\_azure\_connection\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_equinix_ipv4_ip"></a> [azure\_equinix\_ipv4\_ip](#input\_azure\_equinix\_ipv4\_ip) | n/a | `any` | n/a | yes |
| <a name="input_azure_equinix_ipv6_ip"></a> [azure\_equinix\_ipv6\_ip](#input\_azure\_equinix\_ipv6\_ip) | n/a | `any` | n/a | yes |
| <a name="input_azure_fabric_sp_name"></a> [azure\_fabric\_sp\_name](#input\_azure\_fabric\_sp\_name) | n/a | `any` | n/a | yes |
| <a name="input_azure_notifications_emails"></a> [azure\_notifications\_emails](#input\_azure\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_azure_notifications_type"></a> [azure\_notifications\_type](#input\_azure\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_peering_type"></a> [azure\_peering\_type](#input\_azure\_peering\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_purchase_order_number"></a> [azure\_purchase\_order\_number](#input\_azure\_purchase\_order\_number) | n/a | `any` | n/a | yes |
| <a name="input_azure_redundancy"></a> [azure\_redundancy](#input\_azure\_redundancy) | n/a | `any` | n/a | yes |
| <a name="input_azure_rp_name"></a> [azure\_rp\_name](#input\_azure\_rp\_name) | n/a | `any` | n/a | yes |
| <a name="input_azure_rp_type"></a> [azure\_rp\_type](#input\_azure\_rp\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_zside_ap_authentication_key"></a> [azure\_zside\_ap\_authentication\_key](#input\_azure\_zside\_ap\_authentication\_key) | n/a | `any` | n/a | yes |
| <a name="input_azure_zside_ap_profile_type"></a> [azure\_zside\_ap\_profile\_type](#input\_azure\_zside\_ap\_profile\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_zside_ap_type"></a> [azure\_zside\_ap\_type](#input\_azure\_zside\_ap\_type) | n/a | `any` | n/a | yes |
| <a name="input_azure_zside_location"></a> [azure\_zside\_location](#input\_azure\_zside\_location) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | n/a | `any` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | n/a | `any` | n/a | yes |
| <a name="input_fcr_account"></a> [fcr\_account](#input\_fcr\_account) | n/a | `any` | n/a | yes |
| <a name="input_fcr_location"></a> [fcr\_location](#input\_fcr\_location) | n/a | `any` | n/a | yes |
| <a name="input_fcr_name"></a> [fcr\_name](#input\_fcr\_name) | n/a | `any` | n/a | yes |
| <a name="input_fcr_package"></a> [fcr\_package](#input\_fcr\_package) | n/a | `any` | n/a | yes |
| <a name="input_fcr_project"></a> [fcr\_project](#input\_fcr\_project) | n/a | `any` | n/a | yes |
| <a name="input_fcr_type"></a> [fcr\_type](#input\_fcr\_type) | n/a | `any` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | n/a | `any` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | n/a | `any` | n/a | yes |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_connection_id"></a> [aws\_connection\_id](#output\_aws\_connection\_id) | n/a |
| <a name="output_aws_connection_name"></a> [aws\_connection\_name](#output\_aws\_connection\_name) | n/a |
| <a name="output_aws_rp_bgp_id"></a> [aws\_rp\_bgp\_id](#output\_aws\_rp\_bgp\_id) | n/a |
| <a name="output_aws_rp_direct_id"></a> [aws\_rp\_direct\_id](#output\_aws\_rp\_direct\_id) | n/a |
| <a name="output_azure_connection_id"></a> [azure\_connection\_id](#output\_azure\_connection\_id) | n/a |
| <a name="output_azure_connection_name"></a> [azure\_connection\_name](#output\_azure\_connection\_name) | n/a |
| <a name="output_azure_rp_bgp_id"></a> [azure\_rp\_bgp\_id](#output\_azure\_rp\_bgp\_id) | n/a |
| <a name="output_azure_rp_direct_id"></a> [azure\_rp\_direct\_id](#output\_azure\_rp\_direct\_id) | n/a |
| <a name="output_fcr_result"></a> [fcr\_result](#output\_fcr\_result) | n/a |
<!-- END_TF_DOCS -->