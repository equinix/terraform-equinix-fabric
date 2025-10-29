terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      # source  = "equinix/equinix"
      # version = ">= 3.2.0"
      source = "developer.equinix.com/terraform/equinix"
      version = "9.0.0"
    }
  }
}
