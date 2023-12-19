provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id

  skip_provider_registration = true
}
resource "azurerm_resource_group" "fcr2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "fcr2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.fcr2azure.name
  location              = azurerm_resource_group.fcr2azure.location
  service_provider_name = var.azure_service_provider_name
  peering_location      = var.azure_peering_location
  bandwidth_in_mbps     = var.bandwidth
  sku {
    tier   = var.azure_tier
    family = var.azure_family
  }
  allow_classic_operations = false
  tags = {
    environment = var.azure_environment
  }
}
module "cloud_router_azure_connection" {
  source = "../../modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.fcr2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_type  = var.aside_ap_type
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = azurerm_express_route_circuit.fcr2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_peering_type          = var.zside_peering_type
  zside_fabric_sp_name        = var.zside_fabric_sp_name
}
