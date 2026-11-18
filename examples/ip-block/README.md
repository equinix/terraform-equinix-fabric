# Equinix Fabric IP Block - Create, Get and Search

One flow covering the IP block lifecycle:

Everything is done directly with provider resources and data sources:

1. **Create**
2. **Get** it by UUID
3. **Search** (runs after the create, so the result is never empty)

`terraform destroy` removes the IP block at the end.
Needs an `equinix/equinix` provider release that includes the `equinix_fabric_ip_block` resource (v5.4.0+).
