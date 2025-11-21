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

#Azure Provider
variable "azure_client_id" {
  description = "Azure Client id"
  type        = string
  sensitive   = true
}
variable "azure_client_secret" {
  description = "Azure Secret value"
  type        = string
  sensitive   = true
}
variable "azure_tenant_id" {
  description = "Azure Tenant id"
  type        = string
  sensitive   = true
}
variable "azure_subscription_id" {
  description = "Azure Subscription id"
  type        = string
  sensitive   = true
}
variable "azure_resource_name" {
  description = "The name of Azure Resource"
  type        = string
}
variable "azure_location" {
  description = "The location of Azure service provider(resource)"
  type        = string
}
variable "azure_service_key_name" {
  description = "Azure Service Key Name"
  type        = string
}
variable "azure_service_provider_name" {
  description = "The name of Azure Service Provider"
  type        = string
  default     = ""
}
variable "azure_peering_location" {
  description = "The name of the peering location (not the Azure resource location)"
  type        = string
  default     = ""
}
variable "azure_tier" {
  description = "The Service tier. Possible values are Basic, Local, Standard or Premium"
  type        = string
}
variable "azure_family" {
  description = "The billing mode for bandwidth. Possible values are MeteredData or UnlimitedData"
  type        = string
}
variable "azure_environment" {
  description = "The Cloud environment which should be used for Service Key"
  type        = string
}
#Connection Variables
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
  default     = 50
}
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
  default     = ""
}
variable "aside_vd_type" {
  description = "Virtual Device type - EDGE"
  type        = string
  default     = ""
}
variable "aside_vd_uuid" {
  description = "Virtual Device UUID"
  type        = string
  default     = ""
}
variable "zside_ap_type" {
  description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
  type        = string
}
variable "zside_ap_profile_type" {
  description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
  type        = string
}
variable "zside_location" {
  description = "Access point metro code"
  type        = string
}
variable "zside_sp_name" {
  description = "Equinix Service Profile Name"
  type        = string
}
variable "zside_peering_type" {
  description = "Zside Access Point Peering type. Available values; PRIVATE, MICROSOFT, PUBLIC, MANUAL"
  type        = string
}
variable "peering_type" {
  description = "Peering type"
  type        = string
  default     = ""
}
variable "peer_asn" {
  description = "Peer asn number"
  type        = number
}
variable "peering_vlan_id" {
  description = "VLAN ID to establish this peering on"
  type        = number
}
variable "primary_peer_address_prefix" {
  description = "Subnet for the primary link"
  type        = string
  default     = ""
}
variable "secondary_peer_address_prefix" {
  description = "Subnet for the secondary link"
  type        = string
  default     = ""
}
