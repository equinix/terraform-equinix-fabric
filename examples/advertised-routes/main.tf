provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

data "equinix_advertised_routes" "routes" {
  connection_id = var.connection_id
  filter = {
    property = "/type"
    operator = "IN"
    values   = var.types
  }
  pagination = {
    limit  = 100
    offset = 0
  }
  sort = {
    property  = var.sort_property
    direction = var.sort_direction
  }
}
