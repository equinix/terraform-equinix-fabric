output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "azurerm_resource_group_id" {
  value = azurerm_resource_group.metal2azure.id
}
output "azurerm_express_route_circuit" {
  value = azurerm_express_route_circuit.metal2azure.id
}
output "metal_azure_connection" {
  value = module.metal_2_azure_connection.primary_connection
  sensitive = true
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
