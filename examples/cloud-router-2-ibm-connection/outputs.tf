output "ibm2_connection" {
  value     = module.create_fcr_2_ibm2_connection.primary_connection
  sensitive = true
}
# output "IBM_Gateway_Action_Id" {
#   value = ibm_dl_gateway_action.test_dl_gateway_action.id
# }

output "ibm2_connection_id" {
  value = module.create_fcr_2_ibm2_connection.primary_connection_id
}
