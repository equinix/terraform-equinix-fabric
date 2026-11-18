variable "create" {
  description = "Create the resource."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the Internet Access service"
  type        = string
}

variable "type" {
  description = "Type of the service. One of: SINGLE_IA, DUAL_IA"
  type        = string
  default     = "SINGLE_IA"
}

variable "project_id" {
  description = "Equinix subscriber-assigned project ID"
  type        = string
}

variable "account_number" {
  description = "Account number the service is billed to"
  type        = string
}

variable "billing_type" {
  description = "Billing type. One of: FIXED, USAGE_BASED, BURST_BASED"
  type        = string
  default     = "FIXED"
}

variable "bandwidth" {
  description = "Bandwidth of the service in Mbps"
  type        = number
  default     = null
}

variable "bandwidth_commit" {
  description = "Minimum bandwidth commit for the burst billing variant of the service"
  type        = number
  default     = null
}

variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = null
}

variable "routing_protocol_type" {
  description = "Routing protocol type. One of: BGP, DIRECT, STATIC"
  type        = string
  default     = "DIRECT"
}

variable "connection_uuids" {
  description = "UUIDs of existing Fabric IA_VC connections to attach (two for DUAL_IA)"
  type        = list(string)
}

variable "asn_uuid" {
  description = "BGP only. UUID of an equinix_fabric_asn used on the Equinix side"
  type        = string
  default     = null
}

variable "customer_asn" {
  description = "BGP only. Customer ASN number"
  type        = number
  default     = null
}

variable "customer_asn_range" {
  description = "BGP only. Customer ASN range. One of: BITS_16, BITS_32"
  type        = string
  default     = null
}

variable "bgp_auth_key" {
  description = "BGP only. BGP authentication key"
  type        = string
  default     = null
  sensitive   = true
}

variable "export_policy" {
  description = "BGP only. Export policy. One of: FULL, DEFAULT, FULL_DEFAULT, PARTIAL"
  type        = string
  default     = null
}

variable "customer_route_ip_block_uuids" {
  description = "UUIDs of IP blocks (equinix_fabric_ip_block) announced as customer routes"
  type        = list(string)
  default     = []
}
