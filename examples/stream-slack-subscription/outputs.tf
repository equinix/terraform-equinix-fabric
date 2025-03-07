output "stream" {
  value     = module.stream_slack_subscription.first_stream
  sensitive = true
}

output "slack_subscription" {
  value     = module.stream_slack_subscription.slack_subscription
  sensitive = true
}
