output "first_stream" {
  value = equinix_fabric_stream.stream1
  sensitive = true
}

output "second_stream" {
  value = local.second_stream ? equinix_fabric_stream.stream2[0] : null
  sensitive = true
}

output "splunk_subscription" {
  value = var.splunk_uri != "" ? equinix_fabric_stream_subscription.splunk[0] : null
  sensitive = true
}

output "slack_subscription" {
  value = var.slack_uri != "" ? equinix_fabric_stream_subscription.slack[0] : null
  sensitive = true
}

output "msteams_subscription" {
  value = var.msteams_uri != "" ? equinix_fabric_stream_subscription.msteams[0] : null
  sensitive = true
}

output "pagerduty_subscription" {
  value = var.pagerduty_host != "" ? equinix_fabric_stream_subscription.pagerduty[0] : null
  sensitive = true
}

output "datadog_subscription" {
  value = var.datadog_host != "" ? equinix_fabric_stream_subscription.datadog[0] : null
  sensitive = true
}
