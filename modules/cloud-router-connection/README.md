## Equinix Fabric Developer Documentation

To see the documentation for the APIs that the Fabric Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Fabric Developer Portal](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_fabric_connection.primary_cloud_router_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_connection.secondary_cloud_router_connection](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/fabric_connection) | resource |
| [equinix_fabric_ports.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_ports) | data source |
| [equinix_fabric_service_profiles.zside](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/fabric_service_profiles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]` | `list(object({ key = string, value = string }))` | `[]` | no |
| <a name="input_aside_sec_fcr_uuid"></a> [aside\_sec\_fcr\_uuid](#input\_aside\_sec\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier for Secondary Connection | `string` | `""` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | `""` | no |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_secondary_bandwidth"></a> [secondary\_bandwidth](#input\_secondary\_bandwidth) | Connection bandwidth in Mbps | `number` | `50` | no |
| <a name="input_secondary_connection_name"></a> [secondary\_connection\_name](#input\_secondary\_connection\_name) | Secondary Connection name | `string` | `""` | no |
| <a name="input_zside_ap_authentication_key"></a> [zside\_ap\_authentication\_key](#input\_zside\_ap\_authentication\_key) | Authentication key for provider based connections | `string` | `""` | no |
| <a name="input_zside_ap_profile_type"></a> [zside\_ap\_profile\_type](#input\_zside\_ap\_profile\_type) | Service profile type - L2\_PROFILE, L3\_PROFILE, ECIA\_PROFILE, ECMC\_PROFILE | `string` | `"L2_PROFILE"` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"SP"` | no |
| <a name="input_zside_fabric_sp_name"></a> [zside\_fabric\_sp\_name](#input\_zside\_fabric\_sp\_name) | Equinix Service Profile Name | `string` | `""` | no |
| <a name="input_zside_location"></a> [zside\_location](#input\_zside\_location) | Access point metro code | `string` | `"SP"` | no |
| <a name="input_zside_network_uuid"></a> [zside\_network\_uuid](#input\_zside\_network\_uuid) | Network UUID | `string` | `""` | no |
| <a name="input_zside_peering_type"></a> [zside\_peering\_type](#input\_zside\_peering\_type) | Access point peering type - PRIVATE, MICROSOFT, PUBLIC, MANUAL | `string` | `"PRIVATE"` | no |
| <a name="input_zside_port_name"></a> [zside\_port\_name](#input\_zside\_port\_name) | Equinix Zside Port Name | `string` | `""` | no |
| <a name="input_zside_seller_region"></a> [zside\_seller\_region](#input\_zside\_seller\_region) | Access point seller region | `string` | `""` | no |
| <a name="input_zside_vlan_inner_tag"></a> [zside\_vlan\_inner\_tag](#input\_zside\_vlan\_inner\_tag) | Access point protocol Vlan tag number for QINQ connections | `string` | `""` | no |
| <a name="input_zside_vlan_outer_tag"></a> [zside\_vlan\_outer\_tag](#input\_zside\_vlan\_outer\_tag) | Access point protocol Vlan tag number for DOT1Q or QINQ connections | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_connection_id"></a> [primary\_connection\_id](#output\_primary\_connection\_id) | n/a |
| <a name="output_secondary_connection_id"></a> [secondary\_connection\_id](#output\_secondary\_connection\_id) | n/a |
<!-- END_TF_DOCS -->
