output "stream" {
  value     = module.stream_grafana_subscription.first_stream.id
  sensitive = true
}

output "stream_subscription" {
  value     = module.stream_grafana_subscription.grafana_subscription
  sensitive = true
}
