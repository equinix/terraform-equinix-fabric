output "azurerm_resource_group_id" {
  value = azurerm_resource_group.fcr2azure.id
}
output "azurerm_express_route_circuit" {
  value = azurerm_express_route_circuit.fcr2azure.id
}
output "azure_primary_connection_id" {
  value = module.cloud_router_azure_redundant_connection.primary_connection_id
}
output "azure_secondary_connection_id" {
  value = var.secondary_connection_name != "" ? module.cloud_router_azure_redundant_connection.secondary_connection_id : null
}
