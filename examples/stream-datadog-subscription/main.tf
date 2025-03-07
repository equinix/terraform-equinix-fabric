provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_datadog_subscription" {
  source = "../../modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  datadog_name              = var.datadog_name
  datadog_description       = var.datadog_description
  datadog_enabled           = var.datadog_enabled
  datadog_host              = var.datadog_host
  datadog_api_key           = var.datadog_api_key
  datadog_application_key   = var.datadog_application_key
  datadog_filters           = var.datadog_filters
  datadog_event_exceptions  = var.datadog_event_exceptions
  datadog_event_selections  = var.datadog_event_selections
  datadog_metric_exceptions = var.datadog_metric_exceptions
  datadog_metric_selections = var.datadog_metric_selections
  datadog_event_uri         = var.datadog_event_uri
  datadog_metric_uri        = var.datadog_metric_uri
}
