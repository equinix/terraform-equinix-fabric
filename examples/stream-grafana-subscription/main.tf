provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_grafana_subscription" {
  source = "../../modules/streaming-observability"

  stream_name               = var.stream_name
  stream_description        = var.stream_description

  grafana_name              = var.grafana_name
  grafana_description       = var.grafana_description
  grafana_enabled           = var.grafana_enabled
  grafana_event_exceptions  = var.grafana_event_exceptions
  grafana_event_selections  = var.grafana_event_selections
  grafana_metric_exceptions = var.grafana_metric_exceptions
  grafana_metric_selections = var.grafana_metric_selections
  grafana_event_uri         = var.grafana_event_uri
  grafana_metric_uri        = var.grafana_metric_uri
  grafana_format            = var.grafana_format
}
