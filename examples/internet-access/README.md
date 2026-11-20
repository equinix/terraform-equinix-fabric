# Equinix Fabric Internet Access

Creates an Internet Access (EIA) service through `modules/internet-access`. `terraform destroy` removes it at the end.

The module creates an `IA_VC` connection from `port_uuid` to the Equinix Internet Access service profile, an IP block used as a customer route, and the service attached to both.
The VLAN tag of the connection is generated with `modules/random-vlan-tag`.
For BGP the service can use an existing ASN (`asn_uuid`).
