provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "asn" {
  source = "../../modules/asn"

  create = var.create

  project_id          = var.project_id
  type                = var.type
  location_metro_code = var.metro_code
  range               = var.range
}
