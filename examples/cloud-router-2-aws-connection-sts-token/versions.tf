terraform {
  required_version = ">= 1.5.4"
  required_providers {
    equinix = {
      source = "developer.equinix.com/terraform/equinix"
      version = "9.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
