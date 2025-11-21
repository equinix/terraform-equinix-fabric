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
}

#Azure Provider
resource "azurerm_resource_group" "vd2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "vd2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.vd2azure.name
  location              = azurerm_resource_group.vd2azure.location
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

#Connection
module "create_virtual_device_2_azure_connection" {
  source = "../../modules/virtual-device-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = azurerm_express_route_circuit.vd2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = var.aside_vd_uuid

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_peering_type          = var.zside_peering_type
  zside_ap_authentication_key = azurerm_express_route_circuit.vd2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_sp_name               = var.zside_sp_name
}
resource "azurerm_express_route_circuit_peering" "example" {
  peering_type                  = var.peering_type
  express_route_circuit_name    = azurerm_express_route_circuit.vd2azure.name
  resource_group_name           = azurerm_resource_group.vd2azure.name
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  ipv4_enabled                  = true
  vlan_id                       = var.peering_vlan_id

  microsoft_peering_config {
    advertised_public_prefixes = ["203.0.113.0/24"]
  }

  ipv6 {
    primary_peer_address_prefix   = "2002:db01::/126"
    secondary_peer_address_prefix = "2003:db01::/126"
    enabled                       = true

    microsoft_peering {
      advertised_public_prefixes = ["2002:db01::/126"]
    }
  }
  depends_on = [module.create_virtual_device_2_azure_connection]
}