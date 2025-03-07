output "stream" {
  value     = module.stream_datadog_subscription.first_stream
  sensitive = true
}

output "datadog_subscription" {
  value     = module.stream_datadog_subscription.datadog_subscription
  sensitive = true
}
