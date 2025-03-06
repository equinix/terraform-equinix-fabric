provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_slack_subscription" {
  source = "../../modules/streaming-observability"

  stream_name = var.stream_name
  stream_description = var.stream_description

  slack_name = var.slack_name
  slack_description = var.slack_description
  slack_enabled = var.slack_enabled
  slack_uri = var.slack_uri
  slack_filters = var.slack_filters
  slack_event_exceptions = var.slack_event_exceptions
  slack_event_selections = var.slack_event_selections
  slack_metric_exceptions = var.slack_metric_exceptions
  slack_metric_selections = var.slack_metric_selections
}
