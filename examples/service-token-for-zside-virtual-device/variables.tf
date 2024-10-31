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
variable "network_public_key_name" {
  description = "The name of SSH key used for identification."
  type        = string
}
variable "network_public_key" {
  description = "The SSH public key"
  type        = string
  sensitive   = true
}

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
variable "notifications_type" {
  description = "Notification Type - ALL is the only type currently supported"
  type        = string
}
variable "notifications_emails" {
  description = "Array of contact emails"
  type        = list(string)
}
variable "connection_type" {
  description = "Type of Connection supported by Service Token you will create; EVPL_VC, EVPLAN_VC, EPLAN_VC, IPWAN_VC"
  type        = string
}
variable "supported_bandwidths" {
  description = "List of permitted bandwidths"
  type        = list
}
variable "zside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "zside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
}
variable "zside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_interface_type" {
  description = "Interface Type"
  type        = string
}
variable "zside_interface_id" {
  description = "Interface Id"
  type        = string
}
