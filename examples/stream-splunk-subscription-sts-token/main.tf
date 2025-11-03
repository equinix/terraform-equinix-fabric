provider "equinix" {
  sts_source_token = var.sts_source_token
  sts_auth_scope = var.sts_auth_scope
}

module "stream_splunk_subscription" {
  source = "../../modules/streaming-observability"

  stream_name        = var.stream_name
  stream_description = var.stream_description

  splunk_enabled           = var.splunk_enabled
  splunk_access_token      = var.splunk_access_token
  splunk_name              = var.splunk_name
  splunk_description       = var.splunk_description
  splunk_uri               = var.splunk_uri
  splunk_filters           = var.splunk_filters
  splunk_event_exceptions  = var.splunk_event_exceptions
  splunk_event_selections  = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source            = var.splunk_source
  splunk_event_index       = var.splunk_event_index
  splunk_metric_index      = var.splunk_metric_index
}
