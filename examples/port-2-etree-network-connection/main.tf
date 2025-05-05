provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_network" "etree_network" {
  type = "EVPTREE"
  name = "test_evptree_create_tf"
  scope = "LOCAL"
  notifications {
    emails = ["dbhola@equinix.com"]
    type = "ALL"
  }
  project {
    project_id = "d467b426-98a6-4854-afa1-f620ce6799bb"
  }
}
