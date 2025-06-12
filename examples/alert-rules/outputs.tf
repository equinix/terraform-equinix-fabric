output "stream_alert_rule_id" {
  value = equinix_fabric_stream_alert_rule.alert_rule.uuid
}
output "stream_alert_rule_state" {
  value = equinix_fabric_stream_alert_rule.alert_rule.state
}
output "data_stream_alert_rule_id" {
  value = data.equinix_fabric_stream_alert_rule.data_alert_rule.uuid
}
output "data_stream_alert_rules_id" {
  value = data.equinix_fabric_stream_alert_rules.data_alert_rules.data[0].uuid
}
