terraform {
  required_version = ">= 1.5.4"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
}
