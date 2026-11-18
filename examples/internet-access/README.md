# Equinix Fabric Internet Access - Create, Get and Search

One flow covering the Internet Access (EIA) service lifecycle:

Create is done by `modules/internet-access`, get and search by data sources in the example:

1. **Create** the service.
2. **Get** it by UUID.
3. **Search** it by name (runs after the create).

`terraform destroy` removes the service at the end.

An `IA_VC` connection from `port_uuid` to the Equinix Internet Access service profile is created first (`modules/port-connection`) and attached to the service.
For BGP the service can use an ASN from the `asn` example (`asn_uuid`).
