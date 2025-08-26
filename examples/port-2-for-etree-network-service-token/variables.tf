
#Service Token
variable "service_token_name" {
  description = "Service Token Name"
  type        = string
}
variable "service_token_type" {
  description = "Service Token Type; VC_TOKEN,EPL_TOKEN"
  type        = string
}
variable "service_token_description" {
  description = "Service Token Description"
  type        = string
}
variable "service_token_expiration_date_time" {
  description = "Expiration date and time of the service token; 2020-11-06T07:00:00"
  type        = string
}
variable "supported_bandwidths" {
  description = "List of permitted bandwidths"
  type        = list
  default     = []
}
variable "zside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "zside_network_type" {
  description = "Network type"
  type        = string
}
variable "zside_network_uuid" {
  description = "Network UUID"
  type        = string
}
variable "role" {
  description = "Role of network"
  type        = string
}
variable "equinix_client_id" {
  description = "Equinix client ID (consumer key), obtained after registering app in the developer platform"
  type        = string
  sensitive   = true
}
variable "equinix_client_secret" {
  description = "Equinix client secret ID (consumer secret), obtained after registering app in the developer platform"
  type        = string
  sensitive   = true
}
variable "connection_name" {
  description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
  type        = string
}
variable "connection_type" {
  description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
  type        = string
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
variable "term_length" {
  description = "Order Term Length"
  type        = number
  default     = 1
}
variable "aside_port_name" {
  description = "Equinix A-Side Port Name"
  type        = string
}
variable "aside_location" {
  description = "Aside metro code"
  type        = string
}
variable "aside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
variable "aside_vlan_inner_tag" {
  description = "Vlan Inner Tag information, inner vlanCTag for QINQ connections"
  type        = string
  default     = ""
}
variable "additional_info" {
  description = "Additional info parameters. It's a list of maps containing 'key' and 'value' keys with their corresponding values."
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
variable "aside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
  default     = ""
}
variable "aside_network_uuid" {
  description = "Equinix Network UUID"
  type        = string
  default     = ""
}
variable "network_type" {
  description = "Equinix A-Side Network Type"
  type        = string
}
variable "network_name" {
  description = "Equinix Network Name"
  type        = string
}
variable "network_scope" {
  description = "Equinix Network Scope"
  type        = string
}