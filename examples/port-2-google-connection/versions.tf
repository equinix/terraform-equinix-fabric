terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.9.0"
    }
    google = {
      source = "hashicorp/google"
      version = ">= 5.17.0"
    }
  }
}
