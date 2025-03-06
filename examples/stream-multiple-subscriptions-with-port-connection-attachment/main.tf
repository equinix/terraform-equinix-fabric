provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "stream_subscriptions" {
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

  splunk_enabled = var.splunk_enabled
  splunk_access_token = var.splunk_access_token
  splunk_name = var.splunk_name
  splunk_description = var.splunk_description
  splunk_uri = var.splunk_uri
  splunk_filters = var.splunk_filters
  splunk_event_exceptions = var.splunk_event_exceptions
  splunk_event_selections = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source = var.splunk_source
  splunk_event_index = var.splunk_event_index
  splunk_metric_index = var.splunk_metric_index

  msteams_name = var.msteams_name
  msteams_description = var.msteams_description
  msteams_enabled = var.msteams_enabled
  msteams_uri = var.msteams_uri
  msteams_filters = var.msteams_filters
  msteams_event_exceptions = var.msteams_event_exceptions
  msteams_event_selections = var.msteams_event_selections
  msteams_metric_exceptions = var.msteams_metric_exceptions
  msteams_metric_selections = var.msteams_metric_selections

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

  datadog_name = var.datadog_name
  datadog_description = var.datadog_description
  datadog_enabled = var.datadog_enabled
  datadog_host = var.datadog_host
  datadog_api_key = var.datadog_api_key
  datadog_application_key = var.datadog_application_key
  datadog_filters = var.datadog_filters
  datadog_event_exceptions = var.datadog_event_exceptions
  datadog_event_selections = var.datadog_event_selections
  datadog_metric_exceptions = var.datadog_metric_exceptions
  datadog_metric_selections = var.datadog_metric_selections
  datadog_event_uri = var.datadog_event_uri
  datadog_metric_uri = var.datadog_metric_uri
}

module "create_port_2_port_connection" {
  source = "../../modules/port-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  # A-side
  aside_port_name = var.aside_port_name
  aside_vlan_tag  = var.aside_vlan_tag

  # Z-side
  zside_ap_type   = var.zside_ap_type
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_tag
  zside_location  = var.zside_location
}

resource "equinix_fabric_stream_attachment" "port_connection_on_stream1" {
  asset_id = module.create_port_2_port_connection.primary_connection_id
  asset = "connections"
  stream_id = module.stream_subscriptions.first_stream.id
}

# Second Aatachment must happen on second stream in module to handle the max subscription per stream limitation
resource "equinix_fabric_stream_attachment" "port_connection_on_stream2" {
  asset_id = module.create_port_2_port_connection.primary_connection_id
  asset = "connections"
  stream_id = module.stream_subscriptions.second_stream.id
}
