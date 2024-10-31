output "ibm2_connection" {
  value = module.create_port_2_ibm2_connection.primary_connection
}
output "IBM_Gateway_Action_Id" {
  value = ibm_dl_gateway_action.test_dl_gateway_action.id
}
