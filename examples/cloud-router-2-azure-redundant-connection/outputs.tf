output "azurerm_resource_group_id" {
  value = azurerm_resource_group.fcr2azure.id
}
output "azurerm_express_route_circuit" {
  value = azurerm_express_route_circuit.fcr2azure.id
}
output "azure_primary_connection" {
  value = module.cloud_router_azure_redundant_connection.primary_connection
}
output "azure_secondary_connection" {
  value = module.cloud_router_azure_redundant_connection.secondary_connection
}
