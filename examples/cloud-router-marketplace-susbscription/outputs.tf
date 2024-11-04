output "cloud_router" {
  value = equinix_fabric_cloud_router.create_fcr_marketplace_subscription
  sensitive = true
}

output "cloud_router_id" {
  value = equinix_fabric_cloud_router.create_fcr_marketplace_subscription.id
}
