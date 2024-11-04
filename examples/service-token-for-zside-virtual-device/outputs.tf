output "service-token" {
  value = equinix_fabric_service_token.service-token
  sensitive = true
}

output "service-token-id" {
  value = equinix_fabric_service_token.service-token.id
}
