resource "equinix_fabric_ip_block" "this" {
  count = var.create ? 1 : 0

  type          = var.type
  prefix_length = var.prefix_length

  project = {
    project_id = var.project_id
  }

  location = var.location_metro_code == null ? null : {
    metro_code = var.location_metro_code
  }

  account = var.account_number == null ? null : {
    account_number = var.account_number
  }
}

data "equinix_fabric_ip_block" "get" {
  ip_block_id = var.create ? equinix_fabric_ip_block.this[0].uuid : data.equinix_fabric_ip_blocks.search.data[0].uuid
}

data "equinix_fabric_ip_blocks" "search" {
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

  depends_on = [equinix_fabric_ip_block.this]
}
