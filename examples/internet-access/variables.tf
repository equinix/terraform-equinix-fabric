variable "equinix_client_id" {
  description = "API Consumer Key available under 'My Apps' in developer portal"
  type        = string
}

variable "equinix_client_secret" {
  description = "API Consumer secret available under 'My Apps' in developer portal"
  type        = string
  sensitive   = true
}

variable "name" {
  description = "Name of the Internet Access service"
  type        = string
}

variable "type" {
  description = "Type of the service. One of: SINGLE_IA, DUAL_IA"
  type        = string
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
}

variable "bandwidth" {
  description = "Bandwidth of the service in Mbps"
  type        = number
}

variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
}

variable "routing_protocol_type" {
  description = "Routing protocol type. One of: BGP, DIRECT, STATIC"
  type        = string
}

variable "port_uuid" {
  description = "UUID of the Fabric port the IA_VC connection starts from"
  type        = string
}

variable "service_profile_uuid" {
  description = "UUID of the Equinix Internet Access service profile (IA_PROFILE)"
  type        = string
}

variable "metro_code" {
  description = "Two-letter metro code of the port and the service profile"
  type        = string
}

variable "connection_name" {
  description = "Name of the IA_VC connection created for the service"
  type        = string
}

variable "connection_bandwidth" {
  description = "Bandwidth of the IA_VC connection in Mbps"
  type        = number
}

variable "asn_uuid" {
  description = "BGP only. UUID of an existing equinix_fabric_asn (see the asn example)"
  type        = string
}

variable "customer_asn" {
  description = "BGP only. Customer ASN number"
  type        = number
}

variable "customer_asn_range" {
  description = "BGP only. Customer ASN range. One of: BITS_16, BITS_32"
  type        = string
}

variable "bgp_auth_key" {
  description = "BGP only. BGP authentication key"
  type        = string
  sensitive   = true
}

variable "export_policy" {
  description = "BGP only. Export policy. One of: FULL, DEFAULT, FULL_DEFAULT, PARTIAL"
  type        = string
}


variable "create" {
  description = "Create the resource. When false the example only runs search and get on existing data"
  type        = bool
  default     = true
}

variable "notifications_emails" {
  description = "Emails notified about the Internet Access connection"
  type        = list(string)
}

variable "ip_block_prefix_length" {
  description = "Prefix length of the IP block used as the customer route"
  type        = number
}
