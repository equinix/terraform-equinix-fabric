terraform {
  required_version = ">= 1.5.2"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = ">= 1.25.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
