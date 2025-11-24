output "stream" {
  value     = module.stream_splunk_subscription.first_stream
  sensitive = true
}

output "splunk_subscription" {
  value     = module.stream_splunk_subscription.splunk_subscription
  sensitive = true
}
