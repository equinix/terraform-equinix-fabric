<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.84.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.84.0 |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.20.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_virtual_device_2_azure_connection"></a> [create\_virtual\_device\_2\_azure\_connection](#module\_create\_virtual\_device\_2\_azure\_connection) | ../../modules/virtual-device-connection | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_circuit.port2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/express_route_circuit) | resource |
| [azurerm_resource_group.port2azure](https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/docs/resources/resource_group) | resource |
| [equinix_network_acl_template.wan-acl-template](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_acl_template) | resource |
| [equinix_network_device.C8KV-SV](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device) | resource |
| [equinix_network_ssh_key.suneeth-ssh](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_ssh_key) | resource |

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
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_endpoint"></a> [equinix\_endpoint](#input\_equinix\_endpoint) | Equinix endpoint URL | `string` | n/a | yes |
| <a name="input_ne_core_count"></a> [ne\_core\_count](#input\_ne\_core\_count) | Core count number | `number` | n/a | yes |
| <a name="input_ne_hostname"></a> [ne\_hostname](#input\_ne\_hostname) | Device hostname prefix | `string` | n/a | yes |
| <a name="input_ne_metro_code"></a> [ne\_metro\_code](#input\_ne\_metro\_code) | Device location metro code | `string` | n/a | yes |
| <a name="input_ne_name"></a> [ne\_name](#input\_ne\_name) | Device Name | `string` | n/a | yes |
| <a name="input_ne_notifications"></a> [ne\_notifications](#input\_ne\_notifications) | List of email addresses that will receive device status notifications | `list(string)` | n/a | yes |
| <a name="input_ne_package_code"></a> [ne\_package\_code](#input\_ne\_package\_code) | Device software package code | `string` | n/a | yes |
| <a name="input_ne_ssh_key_name"></a> [ne\_ssh\_key\_name](#input\_ne\_ssh\_key\_name) | ssh key name for device | `string` | n/a | yes |
| <a name="input_ne_ssh_key_username"></a> [ne\_ssh\_key\_username](#input\_ne\_ssh\_key\_username) | username for ssh key | `string` | n/a | yes |
| <a name="input_ne_term_length"></a> [ne\_term\_length](#input\_ne\_term\_length) | Term length in months | `number` | n/a | yes |
| <a name="input_ne_type_code"></a> [ne\_type\_code](#input\_ne\_type\_code) | n/a | `string` | n/a | yes |
| <a name="input_network_public_key"></a> [network\_public\_key](#input\_network\_public\_key) | The SSH public key | `string` | n/a | yes |
| <a name="input_network_public_key_name"></a> [network\_public\_key\_name](#input\_network\_public\_key\_name) | The name of SSH key used for identification. | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | ACL Template description | `string` | n/a | yes |
| <a name="input_template_dst_port"></a> [template\_dst\_port](#input\_template\_dst\_port) | Inbound traffic destination ports | `string` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | ACL Template Name | `string` | n/a | yes |
| <a name="input_template_protocol"></a> [template\_protocol](#input\_template\_protocol) | Inbound traffic protocol | `string` | n/a | yes |
| <a name="input_template_src_port"></a> [template\_src\_port](#input\_template\_src\_port) | Inbound traffic source ports | `string` | n/a | yes |
| <a name="input_template_subnet"></a> [template\_subnet](#input\_template\_subnet) | Inbound traffic source IP subnets in CIDR format | `string` | n/a | yes |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | n/a | yes |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | n/a | yes |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | n/a | yes |
| <a name="input_zside_sp_name"></a> [zside\_sp\_name](#input\_zside\_sp\_name) | Equinix Service Profile Name | `string` | n/a | yes |
| <a name="input_aside_vd_type"></a> [aside\_vd\_type](#input\_aside\_vd\_type) | Virtual Device type - EDGE | `string` | `""` | no |
| <a name="input_aside_vd_uuid"></a> [aside\_vd\_uuid](#input\_aside\_vd\_uuid) | Virtual Device UUID | `string` | `""` | no |
| <a name="input_azure_peering_location"></a> [azure\_peering\_location](#input\_azure\_peering\_location) | The name of the peering location (not the Azure resource location) | `string` | `""` | no |
| <a name="input_azure_service_provider_name"></a> [azure\_service\_provider\_name](#input\_azure\_service\_provider\_name) | The name of Azure Service Provider | `string` | `""` | no |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | `50` | no |
| <a name="input_ne_account_number"></a> [ne\_account\_number](#input\_ne\_account\_number) | Billing account number for a device | `string` | `0` | no |
| <a name="input_ne_version"></a> [ne\_version](#input\_ne\_version) | Device software version | `string` | `null` | no |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_connection_id"></a> [azure\_connection\_id](#output\_azure\_connection\_id) | n/a |
| <a name="output_virtual_device_id"></a> [virtual\_device\_id](#output\_virtual\_device\_id) | n/a |
<!-- END_TF_DOCS -->