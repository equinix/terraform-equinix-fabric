terraform {
  required_version = ">= 1.15.0"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 4.1.0"
    }
  }
}
