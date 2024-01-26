provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
  endpoint      = var.equinix_endpoint
}
provider "azurerm" {
  features {}
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id

  skip_provider_registration = true
}

#Network Edge Module
resource "equinix_network_acl_template" "wan-acl-template" {
  name        = var.template_name
  description = var.template_description
  inbound_rule {
    subnet   = var.template_subnet
    protocol = var.template_protocol
    src_port = var.template_src_port
    dst_port = var.template_dst_port
  }
}

resource "equinix_network_device" "C8KV-SV" {
  name            = var.ne_name
  metro_code      = var.ne_metro_code
  type_code       = var.ne_type_code
  self_managed    = true
  byol            = true
  package_code    = var.ne_package_code
  notifications   = var.ne_notifications
  hostname        = var.ne_hostname
  account_number  = var.ne_account_number
  version         = var.ne_version
  core_count      = var.ne_core_count
  term_length     = var.ne_term_length

  ssh_key {
    username = var.ne_ssh_key_username
    key_name = var.ne_ssh_key_name
  }
  acl_template_id = equinix_network_acl_template.wan-acl-template.id
}

resource "equinix_network_ssh_key" "suneeth-ssh" {
  name       = var.network_public_key_name
  public_key = var.network_public_key
}

#Azure Provider
resource "azurerm_resource_group" "port2azure" {
  name     = var.azure_resource_name
  location = var.azure_location
}
resource "azurerm_express_route_circuit" "port2azure" {
  name                  = var.azure_service_key_name
  resource_group_name   = azurerm_resource_group.port2azure.name
  location              = azurerm_resource_group.port2azure.location
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
  bandwidth             = azurerm_express_route_circuit.port2azure.bandwidth_in_mbps
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_vd_type = var.aside_vd_type
  aside_vd_uuid = equinix_network_device.C8KV-SV.id

  # Z-side
  zside_ap_type               = var.zside_ap_type
  zside_peering_type          = var.zside_peering_type
  zside_ap_authentication_key = azurerm_express_route_circuit.port2azure.service_key
  zside_ap_profile_type       = var.zside_ap_profile_type
  zside_location              = var.zside_location
  zside_sp_name               = var.zside_sp_name
}
