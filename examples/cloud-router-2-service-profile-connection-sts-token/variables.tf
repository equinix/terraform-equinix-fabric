
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
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
  default     = "SP"
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
  default     = "L2_PROFILE"
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
  default     = "SP"
}
variable "zside_fabric_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "sts_source_token" {
  description = "Equinix STS Source Token, the ID token generated using: python -m oidcsim idtoken --sub {username}"
  type        = string
  sensitive   = true
}
variable "sts_auth_scope" {
  description = "Equinix STS Source Token Authentication Scope in the format: roleassignments:{rootOrg}"
  type        = string
  sensitive   = true
}
variable "cloud_router_name" {
  description = "Name of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_type" {
  description = "Type of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_metro_code" {
  description = "Name of the cloud router created for the connection"
  type        = string
}

variable "cloud_router_package" {
  description = "Package of the cloud router created for the connection"
  type        = string
}

variable "project_id" {
  description = "Id of the Fabric Project for the resources to be created in"
  type        = string
}

variable "account_number" {
  description = "Account number for the cloud router creation"
  type        = number
}
variable "routing_protocol_direct_rp_name" {
  description = "Name of the Direct Routing Protocol Added to the Cloud Router Connection"
  type = string
}
variable "routing_protocol_direct_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type = string
}
variable "routing_protocol_bgp_rp_name" {
  description = "Ipv4 Ip address for Cloud Router Bgp Routing Protocol"
}
variable "routing_protocol_bgp_ipv4_ip" {
  description = "Ipv4 Ip address for Cloud Router Direct Routing Protocol"
  type = string
}
variable "routing_protocol_bgp_customer_asn" {
  description = "Customer ASN number for BGP Routing Protocol"
  type = number
}
variable "route_filter_direction" {
  description = "Direction of the route filtering [INBOUND or OUTBOUND]"
  type        = string
}

variable "route_filter_policy_name" {
  description = "Name of the route filter policy that will be created in this module"
  type        = string
}

variable "route_filter_policy_type" {
  description = "Type of the route filter policy. Should be one of: BGP_IPv4_PREFIX_FILTER, BGP_IPv6_PREFIX_FILTER"
  type        = string
}

variable "route_filter_rules" {
  description = "List of route filter rules to add to the created route filter policy"
  type = list(object({
    prefix       = string,
    name         = optional(string),
    description  = optional(string),
    prefix_match = optional(string),
  }))
}
