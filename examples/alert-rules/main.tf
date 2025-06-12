provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

resource "equinix_fabric_stream" "new_stream" {
  type = "TELEMETRY_STREAM"
  name = "Stream_Test_PFCR"

  description = var.stream_description
  project = {
    project_id = var.project_id
  }
}

resource "equinix_fabric_stream_subscription" "SPLUNK" {
  depends_on = [
    equinix_fabric_stream.new_stream
  ]

  type        = var.subscription_type
  name        = var.subscription_name
  description = var.subscription_description
  stream_id   = equinix_fabric_stream.new_stream.uuid
  enabled     = true
  sink = {
    type = "SPLUNK_HEC"
    uri  = var.uri
    settings = {
      event_index  = var.event_index
      metric_index = var.metric_index
      source       = var.source_splunk
    }
    credential = {
      type         = "ACCESS_TOKEN"
      access_token = var.access_token
    }
  }
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

resource "equinix_fabric_stream_attachment" "asset" {
  depends_on = [
    equinix_fabric_stream.new_stream,
    module.create_port_2_port_connection
  ]
  asset_id  = module.create_port_2_port_connection.primary_connection_id
  asset     = "connections"
  stream_id = equinix_fabric_stream.new_stream.uuid
}

resource "equinix_fabric_stream_alert_rule" "alert_rule" {
  depends_on = [
    equinix_fabric_stream_attachment.asset
  ]
  stream_id          = equinix_fabric_stream.new_stream.uuid
  name               = var.alert_rule_name
  type               = "METRIC_ALERT"
  description        = var.alert_rule_description
  operand            = "ABOVE"
  window_size        = var.window_size
  warning_threshold  = var.warning_threshold
  critical_threshold = var.warning_threshold
  metric_name        = var.metric_name
  resource_selector   = {
    "include" : [
      "*/connections/${module.create_port_2_port_connection.primary_connection_id}"
    ]
  }
}

data "equinix_fabric_stream_alert_rule" "data_alert_rule" {
  depends_on = [
    equinix_fabric_stream.new_stream,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id = equinix_fabric_stream.new_stream.uuid
  alert_rule_id = equinix_fabric_stream_alert_rule.alert_rule.uuid
}

data "equinix_fabric_stream_alert_rules" "data_alert_rules" {
  depends_on = [
    equinix_fabric_stream.new_stream,
    equinix_fabric_stream_alert_rule.alert_rule
  ]
  stream_id = equinix_fabric_stream.new_stream.uuid
  pagination = {
    limit = var.limit
    offset = var.offset
  }
}
