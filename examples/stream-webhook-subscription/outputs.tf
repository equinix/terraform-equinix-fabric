output "stream" {
  value     = module.stream_webhook_subscription.first_stream
  sensitive = true
}

output "webhook_subscription" {
  value     = module.stream_webhook_subscription.webhook_subscription
  sensitive = true
}
