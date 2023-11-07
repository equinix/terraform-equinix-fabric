terraform {
  required_providers {
    equinix = {
      source="developer.equinix.com/terraform/equinix"
      version = "9.0.0"
    }
  }
}

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_aws_connection" {
    source = "../../modules/cloud-router-2-aws"

    fcr_uuid = var.fcr_uuid
    connection_name = var.connection_name
    connection_type = var.connection_type
    notifications_type = var.notifications_type
    notifications_emails = var.notifications_emails
    bandwidth = var.bandwidth
    redundancy = var.redundancy
    purchase_order_number = var.purchase_order_number
    aside_ap_type = var.aside_ap_type
    zside_ap_type = var.zside_ap_type
    zside_ap_authentication_key = var.zside_ap_authentication_key
    zside_ap_profile_type = var.zside_ap_profile_type
    zside_location = var.zside_location
    seller_region = var.seller_region
    fabric_sp_name = var.fabric_sp_name
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
}


