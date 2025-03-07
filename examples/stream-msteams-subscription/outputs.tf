output "stream" {
  value     = module.stream_msteams_subscription.first_stream
  sensitive = true
}

output "msteams_subscription" {
  value     = module.stream_msteams_subscription.msteams_subscription
  sensitive = true
}
