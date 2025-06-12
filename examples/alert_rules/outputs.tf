output "stream_alert_rule_state_1" {
  value = equinix_fabric_stream_alert_rule.alert_rule_1
}

output "stream_alert_rules_type" {
  value = data.equinix_fabric_stream_alert_rules.alert_rules.data[0].type
}

output "stream_alert_rules_uuid" {
  value = data.equinix_fabric_stream_alert_rules.alert_rules.data[0].uuid
}
