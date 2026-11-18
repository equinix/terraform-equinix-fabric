provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vlan_tag" {
  source = "../../modules/random-vlan-tag"
  count  = var.create ? 1 : 0
}

module "ia_connection" {
  source = "../../modules/port-connection"
  count  = var.create ? 1 : 0

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  project_id            = var.project_id
  bandwidth             = var.connection_bandwidth
  notifications_emails  = var.notifications_emails
  aside_port_uuid       = var.port_uuid
  aside_vlan_tag        = module.vlan_tag[0].result_string
  aside_location        = var.metro_code
  zside_ap_type         = var.zside_ap_type
  zside_ap_profile_type = var.zside_ap_profile_type
  zside_sp_uuid         = var.service_profile_uuid
  zside_location        = var.metro_code
}

resource "equinix_fabric_ip_block" "this" {
  count = var.create ? 1 : 0

  type          = var.ip_block_type
  prefix_length = var.ip_block_prefix_length

  project = {
    project_id = var.project_id
  }

  location = {
    metro_code = var.metro_code
  }

  account = {
    account_number = var.account_number
  }
}

module "internet_access" {
  source = "../../modules/internet-access"

  create = var.create

  name                  = var.name
  type                  = var.type
  project_id            = var.project_id
  account_number        = var.account_number
  billing_type          = var.billing_type
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number
  routing_protocol_type = var.routing_protocol_type
  connection_uuids      = var.create ? [module.ia_connection[0].primary_connection.uuid] : []

  asn_uuid           = var.asn_uuid
  customer_asn       = var.customer_asn
  customer_asn_range = var.customer_asn_range
  bgp_auth_key       = var.bgp_auth_key
  export_policy      = var.export_policy

  customer_route_ip_block_uuids = var.create ? [equinix_fabric_ip_block.this[0].uuid] : []
}

data "equinix_fabric_internet_access_services" "search" {
  filter = {
    property = "/project/projectId"
    operator = "="
    values   = [var.project_id]
  }

  pagination = {
    limit  = 20
    offset = 0
  }

  sort = {
    property  = "/updatedAt"
    direction = "DESC"
  }

  depends_on = [module.internet_access]
}

data "equinix_fabric_internet_access_service" "get" {
  internet_access_service_id = var.create ? module.internet_access.uuid : data.equinix_fabric_internet_access_services.search.data[0].uuid
}
