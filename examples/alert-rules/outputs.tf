output "stream_id" {
  value = module.stream_splunk_subscription.first_stream.id
}
output "connection_id" {
  value = module.create_port_2_port_connection.primary_connection_id
}
output "stream_alert_rule_id" {
  value = equinix_fabric_stream_alert_rule.alert_rule.uuid
}
output "stream_alert_rule_state" {
  value = equinix_fabric_stream_alert_rule.alert_rule.state
}
