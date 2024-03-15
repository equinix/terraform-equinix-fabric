# Fabric Cloud Router to Virtual Device Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](../../modules/cloud-router-connection/README.md)
to create a Fabric Connection from a Fabric Cloud Router to Virtual Device.

It leverages the Equinix Terraform Provider and the Fabric Cloud Router Connection
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
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.31.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_router_virtual_device_connection"></a> [cloud\_router\_virtual\_device\_connection](#module\_cloud\_router\_virtual\_device\_connection) | ../../modules/cloud-router-connection | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aside_ap_type"></a> [aside\_ap\_type](#input\_aside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | n/a | yes |
| <a name="input_aside_fcr_uuid"></a> [aside\_fcr\_uuid](#input\_aside\_fcr\_uuid) | Equinix-assigned Fabric Cloud Router identifier | `string` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Connection bandwidth in Mbps | `number` | n/a | yes |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores | `string` | n/a | yes |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Defines the connection type like VG\_VC, EVPL\_VC, EPL\_VC, EC\_VC, IP\_VC, ACCESS\_EPL\_VC | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_notifications_emails"></a> [notifications\_emails](#input\_notifications\_emails) | Array of contact emails | `list(string)` | n/a | yes |
| <a name="input_zside_vd_type"></a> [zside\_vd\_type](#input\_zside\_vd\_type) | Virtual Device type - EDGE | `string` | n/a | yes |
| <a name="input_zside_vd_uuid"></a> [zside\_vd\_uuid](#input\_zside\_vd\_uuid) | Virtual Device UUID | `string` | n/a | yes |
| <a name="input_notifications_type"></a> [notifications\_type](#input\_notifications\_type) | Notification Type - ALL is the only type currently supported | `string` | `"ALL"` | no |
| <a name="input_purchase_order_number"></a> [purchase\_order\_number](#input\_purchase\_order\_number) | Purchase order number | `string` | `""` | no |
| <a name="input_zside_ap_type"></a> [zside\_ap\_type](#input\_zside\_ap\_type) | Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW | `string` | `"VD"` | no |
| <a name="input_zside_interface_id"></a> [zside\_interface\_id](#input\_zside\_interface\_id) | Interface Id | `number` | `null` | no |
| <a name="input_zside_interface_type"></a> [zside\_interface\_type](#input\_zside\_interface\_type) | Virtual Device Interface type - CLOUD, NETWORK | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_FCR_VD_Connection"></a> [FCR\_VD\_Connection](#output\_FCR\_VD\_Connection) | n/a |
<!-- END_TF_DOCS -->