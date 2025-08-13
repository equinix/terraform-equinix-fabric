output "stream" {
  value     = module.stream_grafana_subscription.first_stream
  sensitive = true
}

output "grafana_subscription" {
  value     = module.stream_grafana_subscription.grafana_subscription
  sensitive = true
}
