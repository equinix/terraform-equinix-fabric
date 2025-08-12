output "stream" {
  value     = module.stream_webhook_subscription.first_stream.id
  sensitive = true
}

output "stream_subscription" {
  value     = module.stream_webhook_subscription.webhook_subscription
  sensitive = true
}
