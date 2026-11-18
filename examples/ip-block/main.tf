provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_ip_block" "this" {
  count = var.create ? 1 : 0

  type          = var.type
  prefix_length = var.prefix_length

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

data "equinix_fabric_ip_blocks" "search" {
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
    property  = "/changeLog/createdDateTime"
    direction = "DESC"
  }

  depends_on = [equinix_fabric_ip_block.this]
}

data "equinix_fabric_ip_block" "get" {
  ip_block_id = var.create ? equinix_fabric_ip_block.this[0].uuid : data.equinix_fabric_ip_blocks.search.data[0].uuid
}
