output "oracle_virtual_circuit_id" {
  value = oci_core_virtual_circuit.test_virtual_circuit.id
}
output "oracle_connection_id" {
  value = module.cloud_router_oracle_connection.primary_connection_id
}
