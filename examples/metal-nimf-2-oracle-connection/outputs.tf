output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "oracle_virtual_circuit_id" {
  value = oci_core_virtual_circuit.test_virtual_circuit.id
}
output "metal_oracle_connection_id" {
  value = module.metal_2_oracle_connection.primary_connection_id
}
