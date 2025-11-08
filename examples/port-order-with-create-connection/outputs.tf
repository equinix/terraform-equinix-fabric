output "port_uuid" {
  value = equinix_fabric_port.order.id
}

output "port_state" {
  value = data.equinix_fabric_port.check_active.state
}

output "public_sp_connection_id" {
  value = module.create_port_2_public_sp_connection.primary_connection_id
}

