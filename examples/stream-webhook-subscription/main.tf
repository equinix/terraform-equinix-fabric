provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_webhook_subscription" {
  source = "../../modules/streaming-observability"

  stream_name               = var.stream_name
  stream_description        = var.stream_description

  webhook_name              = var.webhook_name
  webhook_description       = var.webhook_description
  webhook_enabled           = var.webhook_enabled
  webhook_event_exceptions  = var.webhook_event_exceptions
  webhook_event_selections  = var.webhook_event_selections
  webhook_metric_exceptions = var.webhook_metric_exceptions
  webhook_metric_selections = var.webhook_metric_selections
  webhook_event_uri         = var.webhook_event_uri
  webhook_metric_uri         = var.webhook_metric_uri
  webhook_format            = var.webhook_format
}