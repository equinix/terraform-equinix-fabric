variable "connection_uuid" {
  description = "Equinix Connection UUID to Apply the Routing Protocols to"
  type        = string
}
variable "direct_rp_name" {
  description = "Name of the Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv4_ip" {
  description = "IPv4 Address for Direct Routing Protocol"
  type        = string
}
variable "direct_equinix_ipv6_ip" {
  description = "IPv6 Address for Direct Routing Protocol"
  type        = string
}


variable "bgp_rp_name" {
  description = "Name of the BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv4" {
  description = "Customer Peering IPv4 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_customer_peer_ipv6" {
  description = "Customer Peering IPv6 Address for BGP Routing Protocol"
  type        = string
  default     = ""
}
variable "bgp_enabled_ipv4" {
  description = "Boolean Enable Flag for IPv4 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_enabled_ipv6" {
  description = "Boolean Enable Flag for IPv6 Peering on BGP Routing Protocol"
  type        = bool
  default     = true
}
variable "bgp_customer_asn" {
  description = "Customer ASN for BGP Routing Protocol"
  type        = string
  default     = ""
}
