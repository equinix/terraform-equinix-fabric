
variable "fcr_uuid" {
    description = "Equinix-assigned Fabric Cloud Router identifier"
    type = string
}

variable "connection_name" {
    description = "Connection name. An alpha-numeric 24 characters string which can include only hyphens and underscores"
    type = string
}
variable "connection_type" {
    description = "Defines the connection type like VG_VC, EVPL_VC, EPL_VC, EC_VC, IP_VC, ACCESS_EPL_VC"
    type = string
}
variable "notifications_type" {
    description = "Notification Type - ALL,CONNECTION_APPROVAL,SALES_REP_NOTIFICATIONS, NOTIFICATIONS"
    type = string

}
variable "notifications_emails" {
    description = "Array of contact emails"
    type = list(string)
}
variable "bandwidth" {
    description = "Connection bandwidth in Mbps"
    type = number
}
variable "redundancy" {
    description = "Redundancy Priority for the connection"
    type = string
}
variable "purchase_order_number" {
    description = "Purchase order number"
    type = string
}
variable "aside_ap_type" {
    description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
    type = string
}
variable "zside_ap_type" {
    description = "Access point type - COLO, VD, VG, SP, IGW, SUBNET, GW"
    type = string
}
variable "zside_ap_authentication_key" {
    description = "Authentication key for provider based connections"
    type = string
}
variable "zside_ap_profile_type" {
    description = "Service profile type - L2_PROFILE, L3_PROFILE, ECIA_PROFILE, ECMC_PROFILE"
    type = string
}
variable "zside_location" {
    description = "Access point metro code"
    type = string
}
variable "fabric_sp_name" {
    description = "Equinix Service Profile Name"
    type = string
}
variable "seller_region" {
    description = "Access point seller region"
    type = string
}

variable "aws_access_key" {
    description = "AWS Access Key from the AWS Console"
    type = string
}
variable "aws_secret_key" {
    description = "AWS Secret Key from the AWS Console"
    type = string
}
