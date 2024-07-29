output "metal_vlan_id" {
  value = equinix_metal_vlan.vlan-server.id
}
output "metal_connection_id" {
  value = equinix_metal_connection.metal-connection.id
}
output "Metal_IBM2_Connection_Id" {
  value = module.metal_2_ibm2_connection.primary_connection_id
}
output "IBM_Gateway_Action_Id" {
  value = ibm_dl_gateway_action.test_dl_gateway_action.id
}
output "metal_connection_status" {
  value = data.equinix_metal_connection.NIMF-test.status
}
