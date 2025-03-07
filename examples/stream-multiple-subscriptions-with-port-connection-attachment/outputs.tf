output "first_stream" {
  value     = module.stream_subscriptions.first_stream
  sensitive = true
}

output "second_stream" {
  value     = module.stream_subscriptions.second_stream
  sensitive = true
}

output "splunk_subscription" {
  value     = module.stream_subscriptions.splunk_subscription
  sensitive = true
}

output "slack_subscription" {
  value     = module.stream_subscriptions.slack_subscription
  sensitive = true
}

output "msteams_subscription" {
  value     = module.stream_subscriptions.msteams_subscription
  sensitive = true
}

output "pagerduty_subscription" {
  value     = module.stream_subscriptions.pagerduty_subscription
  sensitive = true
}

output "datadog_subscription" {
  value     = module.stream_subscriptions.datadog_subscription
  sensitive = true
}

output "port_connection" {
  value     = module.create_port_2_port_connection.primary_connection
  sensitive = true
}

output "port_attachment_on_first_stream" {
  value     = equinix_fabric_stream_attachment.port_connection_on_stream1
  sensitive = true
}

output "port_attachment_on_second_stream" {
  value     = equinix_fabric_stream_attachment.port_connection_on_stream2
  sensitive = true
}


