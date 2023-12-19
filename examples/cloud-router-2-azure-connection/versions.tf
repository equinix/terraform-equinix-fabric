terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.20.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.84.0"
    }
  }
}
