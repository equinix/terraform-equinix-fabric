provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_servicenow_subscription" {
  source = "../../modules/streaming-observability"

  stream_name                  = var.stream_name
  stream_description           = var.stream_description

  servicenow_name              = var.servicenow_name
  servicenow_description       = var.servicenow_description
  servicenow_enabled           = var.servicenow_enabled
  servicenow_host              = var.servicenow_host
  servicenow_event_exceptions  = var.servicenow_event_exceptions
  servicenow_event_selections  = var.servicenow_event_selections
  servicenow_metric_exceptions = var.servicenow_metric_exceptions
  servicenow_metric_selections = var.servicenow_metric_selections
  servicenow_username          = var.servicenow_username
  servicenow_password          = var.servicenow_password
}
