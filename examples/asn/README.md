# Equinix Fabric ASN - Create, Get and Search

One flow covering the whole ASN lifecycle:

Everything is done by one module (`modules/asn`):

1. **Create**
2. **Get** it by UUID
3. **Search** (runs after the create, so the result is never empty)

`terraform destroy` removes the ASN at the end.
A PUBLIC_ASN needs a signed ownership challenge (`ownership_challenge_type`, `ownership_challenge_signature`, `rir_region`, `number`), so it is not part of this example.
Needs an `equinix/equinix` provider release that includes the `equinix_fabric_asn(s)` resource and data sources (v5.4.0+).
