variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
  sensitive = true
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
  sensitive = true
}
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
  default     = ""
}
variable "notifications_type" {
  description = "Notification Type - ALL is the only type currently supported"
  type        = string
  default     = "ALL"
}
variable "notifications_emails" {
  description = "Array of contact emails"
  type        = list(string)
}
variable "bandwidth" {
  description = "Connection bandwidth in Mbps"
  type        = number
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "aside_fcr_uuid" {
  description = "Equinix-assigned Fabric Cloud Router identifier"
  type        = string
}
variable "zside_port_name" {
  description = "Equinix Zside Port Name"
  type        = string
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_vlan_outer_tag" {
  description = "Access point protocol Vlan tag number for DOT1Q or QINQ connections"
  default     = ""
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = "SP"
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
