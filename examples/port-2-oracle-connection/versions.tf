terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 2.9.0"
    }
    oci = {
      source = "oracle/oci"
      version = "5.36.0"
    }
  }
}
