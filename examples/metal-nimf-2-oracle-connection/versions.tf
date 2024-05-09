terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.36.3"
    }
    oci = {
      source = "oracle/oci"
      version = "5.36.0"
    }
  }
}
