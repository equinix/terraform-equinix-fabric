provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_msteams_subscription" {
  source = "../../modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  msteams_name              = var.msteams_name
  msteams_description       = var.msteams_description
  msteams_enabled           = var.msteams_enabled
  msteams_uri               = var.msteams_uri
  msteams_filters           = var.msteams_filters
  msteams_event_exceptions  = var.msteams_event_exceptions
  msteams_event_selections  = var.msteams_event_selections
  msteams_metric_exceptions = var.msteams_metric_exceptions
  msteams_metric_selections = var.msteams_metric_selections
}
