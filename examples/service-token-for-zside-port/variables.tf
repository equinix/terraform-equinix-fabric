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
variable "allow_remote_connection" {
  description = "allowRemoteConnection"
  type        = bool
}
variable "zside_ap_type" {
  description = "Type of Access point; COLO, VD, NETWORK"
  type        = string
}
variable "zside_port_name" {
  description = "Virtual Device UUID"
  type        = string
}
variable "zside_vlan_tag_type" {
  description = "Vlan Tag Type; DOT1Q or QINQ"
  type        = string
}
variable "zside_vlan_tag" {
  description = "Vlan Tag information, outer vlanSTag for QINQ connections"
  type        = string
}
