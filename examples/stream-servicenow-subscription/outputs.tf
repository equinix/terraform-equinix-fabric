output "stream" {
  value     = module.stream_servicenow_subscription.first_stream
  sensitive = true
}
# output "servicenow_subscription" {
#   value     = module.stream_servicenow_subscription.servicenow_subscription
#   sensitive = true
# }
