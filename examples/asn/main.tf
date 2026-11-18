provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_asn" "this" {
  count = var.create ? 1 : 0

  type  = var.type
  range = var.range

  project = {
    project_id = var.project_id
  }

  location = {
    metro_code = var.metro_code
  }
}

data "equinix_fabric_asns" "search" {
  filter = {
    property = "/state"
    operator = "="
    values   = ["PROVISIONED"]
  }

  pagination = {
    limit  = 20
    offset = 0
  }

  sort = {
    property  = "/changeLog/createdDateTime"
    direction = "DESC"
  }

  depends_on = [equinix_fabric_asn.this]
}

data "equinix_fabric_asn" "get" {
  asn_id = var.create ? equinix_fabric_asn.this[0].uuid : data.equinix_fabric_asns.search.data[0].uuid
}
