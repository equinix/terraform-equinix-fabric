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
module "cloud_router_azure_redundant_connection" {
  source = "../../modules/cloud-router-connection"

  #Primary Connection
  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.fcr2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type               = var.zside_ap_type
  zside_ap_authentication_key = azurerm_express_route_circuit.fcr2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_fabric_sp_name        = var.zside_fabric_sp_name
  zside_peering_type          = var.zside_peering_type

  #Secondary-Connection
  secondary_connection_name = var.secondary_connection_name
  secondary_bandwidth       = var.secondary_bandwidth
}
resource "azurerm_express_route_circuit_peering" "example" {
  peering_type                  = var.peering_type
  express_route_circuit_name    = azurerm_express_route_circuit.fcr2azure.name
  resource_group_name           = azurerm_resource_group.fcr2azure.name
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  ipv4_enabled                  = true
  vlan_id                       = var.peering_vlan_id

  ipv6 {
    primary_peer_address_prefix   = "2002:db01::/126"
    secondary_peer_address_prefix = "2003:db01::/126"
    enabled                       = true
  }
  depends_on = [module.cloud_router_azure_redundant_connection]
}
