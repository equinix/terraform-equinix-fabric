terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source="equinix/equinix"
      version = "3.12.0"
    }
  }
}
