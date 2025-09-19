output "port_order" {
  value = equinix_fabric_port.order
  sensitive = true
}

output "port_order_id" {
  value = equinix_fabric_port.order.id
}

output "public_sp_connection" {
 value = module.create_port_2_public_sp_connection.primary_connection
 sensitive = true
}

output "public_sp_connection_id" {
 value = module.create_port_2_public_sp_connection.primary_connection_id
}