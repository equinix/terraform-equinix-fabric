resource "equinix_fabric_internet_access_service" "this" {
  count = var.create ? 1 : 0

  name             = var.name
  type             = var.type
  bandwidth        = var.bandwidth
  bandwidth_commit = var.bandwidth_commit

  project = {
    project_id = var.project_id
  }

  account = {
    account_number = var.account_number
  }

  billing = {
    type = var.billing_type
  }

  order = var.purchase_order_number == null ? null : {
    purchase_order_number = var.purchase_order_number
  }

  routing_protocol = {
    type               = var.routing_protocol_type
    customer_asn       = var.customer_asn
    customer_asn_range = var.customer_asn_range
    bgp_auth_key       = var.bgp_auth_key
    export_policy      = var.export_policy

    asn = var.asn_uuid == null ? null : {
      uuid = var.asn_uuid
    }

    connections = [for uuid in var.connection_uuids : {
      uuid = uuid
    }]

    customer_routes = length(var.customer_route_ip_block_uuids) == 0 ? null : [for uuid in var.customer_route_ip_block_uuids : {
      ip_block = {
        uuid = uuid
      }
    }]
  }
}

data "equinix_fabric_internet_access_service" "get" {
  internet_access_service_id = var.create ? equinix_fabric_internet_access_service.this[0].uuid : data.equinix_fabric_internet_access_services.search.data[0].uuid
}

data "equinix_fabric_internet_access_services" "search" {
  filter = {
    property = var.search_filter_property
    operator = var.search_filter_operator
    values   = coalesce(var.search_filter_values, [var.project_id])
  }

  pagination = {
    limit  = var.search_pagination_limit
    offset = var.search_pagination_offset
  }

  sort = var.search_sort_property == null ? null : {
    property  = var.search_sort_property
    direction = var.search_sort_direction
  }

  depends_on = [equinix_fabric_internet_access_service.this]
}
