output "stream" {
  value = module.stream_pagerduty_subscription.first_stream
  sensitive = true
}

output "pagerduty_subscription" {
  value = module.stream_pagerduty_subscription.pagerduty_subscription
  sensitive = true
}
