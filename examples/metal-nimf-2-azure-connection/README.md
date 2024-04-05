# Metal to Azure Connection Example

This example shows how to leverage the [Metal Connection Module](../../modules/metalconnection/README.md)
to create a Fabric Connection from Equinix Metal to Azure.

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
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.84.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.84.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metal_2_azure_connection"></a> [metal\_2\_azure\_connection](#module\_metal\_2\_azure\_connection) | ../../modules/metal-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.metal2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/express_route_circuit) | resource |
| [azurerm_resource_group.metal2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/resource_group) | resource |
| [equinix_metal_connection.metal-connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_connection) | resource |
| [equinix_metal_vlan.vlan-server](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Azure Client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Azure Secret value | `string` | n/a | yes |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Cloud environment which should be used for Service Key | `string` | n/a | yes |
| <a name="input_azure_family"></a> [azure\_family](#input\_azure\_family) | The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | The location of Azure service provider(resource) | `string` | n/a | yes |
| <a name="input_azure_resource_name"></a> [azure\_resource\_name](#input\_azure\_resource\_name) | The name of Azure Resource | `string` | n/a | yes |
| <a name="input_azure_service_key_name"></a> [azure\_service\_key\_name](#input\_azure\_service\_key\_name) | Azure Service Key Name | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Azure Tenant id | `string` | n/a | yes |
| <a name="input_azure_tier"></a> [azure\_tier](#input\_azure\_tier) | The Service tier. Possible values are Basic, Local, Standard or Premium | `string` | n/a | yes |
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
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_azure_peering_location"></a> [azure\_peering\_location](#input\_azure\_peering\_location) | The name of the peering location (not the Azure resource location) | `string` | `""` | no |
| <a name="input_azure_service_provider_name"></a> [azure\_service\_provider\_name](#input\_azure\_service\_provider\_name) | The name of Azure Service Provider | `string` | `""` | no |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `"PRIVATE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_express_route_circuit"></a> [azurerm\_express\_route\_circuit](#output\_azurerm\_express\_route\_circuit) | n/a |
| <a name="output_azurerm_resource_group_id"></a> [azurerm\_resource\_group\_id](#output\_azurerm\_resource\_group\_id) | n/a |
| <a name="output_metal_azure_connection_id"></a> [metal\_azure\_connection\_id](#output\_metal\_azure\_connection\_id) | n/a |
| <a name="output_metal_connection_id"></a> [metal\_connection\_id](#output\_metal\_connection\_id) | n/a |
| <a name="output_metal_vlan_id"></a> [metal\_vlan\_id](#output\_metal\_vlan\_id) | n/a |
<!-- END_TF_DOCS -->