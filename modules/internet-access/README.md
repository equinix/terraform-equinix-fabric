# Equinix Fabric Internet Access

Creates everything needed for an Equinix Internet Access service:

1. An `IA_VC` connection from a port to the Internet Access service profile (`equinix_fabric_connection`) on the given VLAN tag.
2. An IP block (`equinix_fabric_ip_block`) used as a customer route.
3. The `equinix_fabric_internet_access_service` attached to the connection and the IP block.

Please refer to the `internet-access` example for usage details.
