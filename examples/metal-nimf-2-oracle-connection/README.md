# Metal to Oracle Connection Example

This example shows how to leverage the [Metal Connection Module](../../modules/metalconnection/README.md)
to create a Fabric Connection from Equinix Metal to Oracle.

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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.36.3 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.36.3 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.36.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal_2_oracle_connection"></a> [metal\_2\_oracle\_connection](#module\_metal\_2\_oracle\_connection) | ../../modules/metal-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [oci_core_virtual_circuit.test_virtual_circuit](https://registry.terraform.io/providers/oracle/oci/5.36.0/docs/resources/core_virtual_circuit) | resource |
| [oci_core_fast_connect_provider_services.fc_provider_services](https://registry.terraform.io/providers/oracle/oci/5.36.0/docs/data-sources/core_fast_connect_provider_services) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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
| <a name="input_oracle_bandwidth"></a> [oracle\_bandwidth](#input\_oracle\_bandwidth) | The provisioned connection bandwidth | `string` | n/a | yes |
| <a name="input_oracle_bgp_peering_ip"></a> [oracle\_bgp\_peering\_ip](#input\_oracle\_bgp\_peering\_ip) | The BGP IPv6 address for the router on the other end of the BGP session from Oracle | `string` | n/a | yes |
| <a name="input_oracle_compartment_id"></a> [oracle\_compartment\_id](#input\_oracle\_compartment\_id) | The OCID of the compartment | `string` | n/a | yes |
| <a name="input_oracle_customer_asn"></a> [oracle\_customer\_asn](#input\_oracle\_customer\_asn) | Oracle BGP ASN | `string` | n/a | yes |
| <a name="input_oracle_customer_bgp_peering_ip"></a> [oracle\_customer\_bgp\_peering\_ip](#input\_oracle\_customer\_bgp\_peering\_ip) | The BGP IPv4 address for the router on the other end of the BGP session from Oracle | `string` | n/a | yes |
| <a name="input_oracle_fastconnect_provider"></a> [oracle\_fastconnect\_provider](#input\_oracle\_fastconnect\_provider) | Fast Connect Provider Name | `string` | n/a | yes |
| <a name="input_oracle_fingerprint"></a> [oracle\_fingerprint](#input\_oracle\_fingerprint) | Fingerprint for the key pair being used | `string` | n/a | yes |
| <a name="input_oracle_gateway_id"></a> [oracle\_gateway\_id](#input\_oracle\_gateway\_id) | The OCID of the dynamic routing gateway (DRG) that virtual circuit uses | `string` | n/a | yes |
| <a name="input_oracle_private_key"></a> [oracle\_private\_key](#input\_oracle\_private\_key) | Oracle Private Key | `string` | n/a | yes |
| <a name="input_oracle_region"></a> [oracle\_region](#input\_oracle\_region) | OCI region | `string` | n/a | yes |
| <a name="input_oracle_tenancy_ocid"></a> [oracle\_tenancy\_ocid](#input\_oracle\_tenancy\_ocid) | Tenancy OCID | `string` | n/a | yes |
| <a name="input_oracle_user_ocid"></a> [oracle\_user\_ocid](#input\_oracle\_user\_ocid) | User OCID | `string` | n/a | yes |
| <a name="input_oracle_vc_display_name"></a> [oracle\_vc\_display\_name](#input\_oracle\_vc\_display\_name) | OCI Virtual Circuit Name | `string` | n/a | yes |
| <a name="input_oracle_vc_type"></a> [oracle\_vc\_type](#input\_oracle\_vc\_type) | The type of IP addresses used in this virtual circuit - PRIVATE | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Equinix Fabric Project Id | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_oracle_connection_id"></a> [metal\_oracle\_connection\_id](#output\_metal\_oracle\_connection\_id) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
<!-- END_TF_DOCS -->