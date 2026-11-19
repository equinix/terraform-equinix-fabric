# Equinix Fabric Internet Access

Creates an Internet Access (EIA) service through `modules/internet-access`. `terraform destroy` removes it at the end.

An `IA_VC` connection from `port_uuid` to the Equinix Internet Access service profile is created first (`modules/port-connection`) and attached to the service.
For BGP the service can use an existing ASN (`asn_uuid`).
