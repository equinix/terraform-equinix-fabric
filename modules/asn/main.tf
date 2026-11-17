resource "equinix_fabric_asn" "this" {
  count = var.create ? 1 : 0

  type       = var.type
  number     = var.number
  range      = var.range
  rir_region = var.rir_region

  project = {
    project_id = var.project_id
  }

  location = var.location_metro_code == null ? null : {
    metro_code = var.location_metro_code
  }

  ownership_challenge_details = var.ownership_challenge_type == null ? null : {
    type      = var.ownership_challenge_type
    signature = var.ownership_challenge_signature
  }
}

data "equinix_fabric_asn" "get" {
  asn_id = var.create ? equinix_fabric_asn.this[0].uuid : data.equinix_fabric_asns.search.data[0].uuid
}

data "equinix_fabric_asns" "search" {
  filter = {
    property = var.search_filter_property
    operator = var.search_filter_operator
    values   = var.search_filter_values
  }

  pagination = {
    limit  = var.search_pagination_limit
    offset = var.search_pagination_offset
  }

  sort = var.search_sort_property == null ? null : {
    property  = var.search_sort_property
    direction = var.search_sort_direction
  }

  depends_on = [equinix_fabric_asn.this]
}
