provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_pagerduty_subscription" {
  source = "../../modules/streaming-observability"

  stream_name = var.stream_name
  stream_description = var.stream_description

  pagerduty_name = var.pagerduty_name
  pagerduty_description = var.pagerduty_description
  pagerduty_enabled = var.pagerduty_enabled
  pagerduty_host = var.pagerduty_host
  pagerduty_integration_key = var.pagerduty_integration_key
  pagerduty_filters = var.pagerduty_filters
  pagerduty_event_exceptions = var.pagerduty_event_exceptions
  pagerduty_event_selections = var.pagerduty_event_selections
  pagerduty_metric_exceptions = var.pagerduty_metric_exceptions
  pagerduty_metric_selections = var.pagerduty_metric_selections
  pagerduty_change_uri = var.pagerduty_change_uri
  pagerduty_alert_uri = var.pagerduty_alert_uri
}
