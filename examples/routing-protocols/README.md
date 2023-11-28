<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_routing_protocols"></a> [routing\_protocols](#module\_routing\_protocols) | ../../modules/routing-protocols | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_uuid"></a> [connection\_uuid](#input\_connection\_uuid) | Equinix Connection UUID to Apply the Routing Protocols to | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv4_ip"></a> [direct\_equinix\_ipv4\_ip](#input\_direct\_equinix\_ipv4\_ip) | IPv4 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_direct_equinix_ipv6_ip"></a> [direct\_equinix\_ipv6\_ip](#input\_direct\_equinix\_ipv6\_ip) | IPv6 Address for Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_direct_rp_name"></a> [direct\_rp\_name](#input\_direct\_rp\_name) | Name of the Direct Routing Protocol | `string` | n/a | yes |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | Equinix client ID (consumer key), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | Equinix client secret ID (consumer secret), obtained after registering app in the developer platform | `string` | n/a | yes |
| <a name="input_bgp_customer_asn"></a> [bgp\_customer\_asn](#input\_bgp\_customer\_asn) | Customer ASN for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv4"></a> [bgp\_customer\_peer\_ipv4](#input\_bgp\_customer\_peer\_ipv4) | Customer Peering IPv4 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_customer_peer_ipv6"></a> [bgp\_customer\_peer\_ipv6](#input\_bgp\_customer\_peer\_ipv6) | Customer Peering IPv6 Address for BGP Routing Protocol | `string` | `""` | no |
| <a name="input_bgp_enabled_ipv4"></a> [bgp\_enabled\_ipv4](#input\_bgp\_enabled\_ipv4) | Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_enabled_ipv6"></a> [bgp\_enabled\_ipv6](#input\_bgp\_enabled\_ipv6) | Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol | `bool` | `true` | no |
| <a name="input_bgp_rp_name"></a> [bgp\_rp\_name](#input\_bgp\_rp\_name) | Name of the BGP Routing Protocol | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bgp_rp_id"></a> [bgp\_rp\_id](#output\_bgp\_rp\_id) | n/a |
| <a name="output_direct_rp_id"></a> [direct\_rp\_id](#output\_direct\_rp\_id) | n/a |
<!-- END_TF_DOCS -->