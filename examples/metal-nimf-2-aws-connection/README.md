# Metal to AWS Connection Example

This example shows how to leverage the [Metal Connection Module](../../modules/metalconnection/README.md)
to create a Fabric Connection from Equinix Metal to AWS.

It leverages the Equinix Terraform Provider and the Metal Connection
Module to setup the connection based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

See example usage below for details on how to use this example.

<!-- Begin Example Usage (Do not edit contents) -->
<!-- End Example Usage -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal_2_aws_connection"></a> [metal\_2\_aws\_connection](#module\_metal\_2\_aws\_connection) | ../../modules/metal-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dx_gateway.aws_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_private_virtual_interface.aws_virtual_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_private_virtual_interface) | resource |
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [aws_dx_connection.aws_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dx_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_gateway_asn"></a> [aws\_gateway\_asn](#input\_aws\_gateway\_asn) | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294 | `number` | n/a | yes |
| <a name="input_aws_gateway_name"></a> [aws\_gateway\_name](#input\_aws\_gateway\_name) | The name of the Gateway | `string` | n/a | yes |
| <a name="input_aws_vif_address_family"></a> [aws\_vif\_address\_family](#input\_aws\_vif\_address\_family) | The address family for the BGP peer. ipv4 or ipv6 | `string` | n/a | yes |
| <a name="input_aws_vif_bgp_asn"></a> [aws\_vif\_bgp\_asn](#input\_aws\_vif\_bgp\_asn) | The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration | `number` | n/a | yes |
| <a name="input_aws_vif_name"></a> [aws\_vif\_name](#input\_aws\_vif\_name) | The name for the virtual interface | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_metal_auth_token"></a> [metal\_auth\_token](#input\_metal\_auth\_token) | Equinix Metal Authentication API Token | `string` | n/a | yes |
| <a name="input_metal_connection_metro"></a> [metal\_connection\_metro](#input\_metal\_connection\_metro) | Metro where the connection will be created | `string` | n/a | yes |
| <a name="input_metal_connection_name"></a> [metal\_connection\_name](#input\_metal\_connection\_name) | Metal Connection Name | `string` | n/a | yes |
| <a name="input_metal_connection_redundancy"></a> [metal\_connection\_redundancy](#input\_metal\_connection\_redundancy) | Metal Connection redundancy - redundant or primary | `string` | n/a | yes |
| <a name="input_metal_connection_speed"></a> [metal\_connection\_speed](#input\_metal\_connection\_speed) | Metal Connection speed - one of 50Mbps, 200Mbps, 500Mbps, 1Gbps, 2Gbps, 5Gbps, 10Gbps | `string` | n/a | yes |
| <a name="input_metal_connection_type"></a> [metal\_connection\_type](#input\_metal\_connection\_type) | Metal Connection type - dedicated , shared or shared\_port\_vlan | `string` | n/a | yes |
| <a name="input_metal_contact_email"></a> [metal\_contact\_email](#input\_metal\_contact\_email) | Preferred email used for communication | `string` | n/a | yes |
| <a name="input_metal_project_id"></a> [metal\_project\_id](#input\_metal\_project\_id) | Metal Project Name | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Equinix Fabric Project Id | `string` | n/a | yes |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | n/a | `string` | n/a | yes |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | n/a | yes |
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values. | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aws_vif_amazon_address"></a> [aws\_vif\_amazon\_address](#input\_aws\_vif\_amazon\_address) | The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_aws_vif_bgp_auth_key"></a> [aws\_vif\_bgp\_auth\_key](#input\_aws\_vif\_bgp\_auth\_key) | The authentication key for BGP configuration | `string` | `""` | no |
| <a name="input_aws_vif_customer_address"></a> [aws\_vif\_customer\_address](#input\_aws\_vif\_customer\_address) | The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers | `string` | `""` | no |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_dx_gateway_id"></a> [aws\_dx\_gateway\_id](#output\_aws\_dx\_gateway\_id) | n/a |
| <a name="output_aws_interface_id"></a> [aws\_interface\_id](#output\_aws\_interface\_id) | n/a |
| <a name="output_metal_aws_connection_id"></a> [metal\_aws\_connection\_id](#output\_metal\_aws\_connection\_id) | n/a |
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
<!-- END_TF_DOCS -->