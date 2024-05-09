output "azurerm_resource_group_id" {
  value = azurerm_resource_group.fcr2azure.id
}
output "azurerm_express_route_circuit" {
  value = azurerm_express_route_circuit.fcr2azure.id
}
output "azure_connection_id" {
  value = module.cloud_router_azure_connection.primary_connection_id
}
