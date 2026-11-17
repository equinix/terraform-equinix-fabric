provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "ip_block" {
  source = "../../modules/ip-block"

  create = var.create

  project_id          = var.project_id
  type                = var.type
  prefix_length       = var.prefix_length
  location_metro_code = var.metro_code
  account_number      = var.account_number
}
