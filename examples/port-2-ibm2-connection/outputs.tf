output "ibm2_connection_id" {
  value = module.create_port_2_ibm2_connection.primary_connection_id
}
output "IBM_Gateway_Action_Id" {
  value = ibm_dl_gateway_action.test_dl_gateway_action.id
}
