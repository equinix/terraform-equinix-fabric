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
  default     = ""
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
variable "aside_vd_uuid" {
  description = "Equinix-assigned Virtual Device identifier"
  type        = string
}
variable "zside_ap_authentication_key" {
  description = "Authentication key for provider based connections"
  type        = string
  sensitive   = true
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
variable "zside_seller_region" {
  description = "Access point seller region"
  type        = string
  default     = ""
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
  default     = ""
}
variable "additional_info" {
  description = "Additional parameters required for some service profiles. It should be a list of maps containing 'key' and 'value  e.g. `[{ key='asn' value = '65000'}, { key='ip' value = '192.168.0.1'}]`"
  type        = list(object({ key = string, value = string }))
  default     = []
  sensitive   = true
}
variable "aws_vif_name" {
  description = "The name for the virtual interface"
  type        = string
}
variable "aws_vif_address_family" {
  description = "The address family for the BGP peer. ipv4 or ipv6"
  type        = string
}
variable "aws_vif_bgp_asn" {
  description = "The autonomous system (AS) number for Border Gateway Protocol (BGP) configuration"
  type        = number
}
variable "aws_vif_amazon_address" {
  description = "The IPv4 CIDR address to use to send traffic to Amazon. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_customer_address" {
  description = "The IPv4 CIDR destination address to which Amazon should send traffic. Required for IPv4 BGP peers"
  type        = string
  default     = ""
}
variable "aws_vif_bgp_auth_key" {
  description = "The authentication key for BGP configuration"
  type        = string
  default     = ""
  sensitive   = true
}
variable "aws_gateway_name" {
  description = "The name of the Gateway"
  type        = string
}
variable "aws_gateway_asn" {
  description = "The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294"
  type        = number
}
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
#Network Edge
variable "ne_name" {
  description = "Device Name"
  type        = string
}
variable "ne_metro_code" {
  description = "Device location metro code"
  type        = string
}
variable "ne_type_code" {
  description = ""
  type        = string
}
variable "ne_package_code" {
  description = "Device software package code"
  type        = string
}
variable "ne_notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
}
variable "ne_hostname" {
  description = "Device hostname prefix"
  type        = string
}
variable "ne_account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}
variable "ne_version" {
  description = "Device software version"
  type        = string
  default     = null
}
variable "ne_core_count" {
  description = "Core count number"
  type        = number
}
variable "ne_term_length" {
  description = "Term length in months"
  type        = number
}
variable "ne_ssh_key_username" {
  description = "username for ssh key"
  type        = string
}
variable "ne_ssh_key_name" {
  description = "ssh key name for device"
  type        = string
}
##NE Acl Template
variable "template_name" {
  description = "ACL Template Name"
  type        = string
}
variable "template_description" {
  description = "ACL Template description"
  type        = string
}
variable "template_subnet" {
  description = "Inbound traffic source IP subnets in CIDR format"
  type        = string
}
variable "template_protocol" {
  description = "Inbound traffic protocol"
  type        = string
}
variable "template_src_port" {
  description = "Inbound traffic source ports"
  type        = string
}
variable "template_dst_port" {
  description = "Inbound traffic destination ports"
  type        = string
}