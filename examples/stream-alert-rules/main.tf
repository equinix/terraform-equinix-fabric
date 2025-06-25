provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
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
  splunk_event_exceptions  = var.splunk_event_exceptions
  splunk_event_selections  = var.splunk_event_exceptions
  splunk_metric_exceptions = var.splunk_metric_exceptions
  splunk_metric_selections = var.splunk_metric_selections
  splunk_source            = var.splunk_source
  splunk_event_index       = var.splunk_event_index
  splunk_metric_index      = var.splunk_metric_index
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

resource "equinix_fabric_stream_attachment" "attachment" {
  depends_on = [
    module.stream_splunk_subscription,
    module.create_port_2_port_connection
  ]

  asset_id  = module.create_port_2_port_connection.primary_connection_id
  asset     = var.asset_type
  stream_id =  module.stream_splunk_subscription.first_stream.id
}

resource "equinix_fabric_stream_alert_rule" "alert_rule" {
  depends_on = [
    equinix_fabric_stream_attachment.attachment
  ]
  type               = "METRIC_ALERT"
  stream_id          =  module.stream_splunk_subscription.first_stream.id
  name               = var.alert_rule_name
  description        = var.alert_rule_description
  operand            = var.operand
  window_size        = var.window_size
  warning_threshold  = var.warning_threshold
  critical_threshold = var.critical_threshold
  metric_name        = var.metric_name
  resource_selector  = {
    "include" = [
      "*/${equinix_fabric_stream_attachment.attachment.asset}/${module.create_port_2_port_connection.primary_connection_id}"
    ]
  }
}

data "equinix_fabric_stream_alert_rule" "alert_rule" {
  depends_on = [
    module.stream_splunk_subscription,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id =  module.stream_splunk_subscription.first_stream.id
  alert_rule_id = equinix_fabric_stream_alert_rule.alert_rule.id
}

data "equinix_fabric_stream_alert_rules" "alert_rules" {
  depends_on = [
    module.stream_splunk_subscription,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id =  module.stream_splunk_subscription.first_stream.id
  pagination = {
    limit = var.limit
    offset = var.offset
  }
}
