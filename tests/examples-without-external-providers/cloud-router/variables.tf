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
variable "fcr_name" {
  description = "Fabric Cloud Router Name"
  type        = string
}
variable "fcr_type" {
  description = "Fabric Cloud Router Type like XF_ROUTER"
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
variable "purchase_order_number" {
  description = "Purchase order number"
  type        = string
}
variable "fcr_location" {
  description = "Fabric Cloud Router Location"
  type        = string
}
variable "fcr_package" {
  description = "Fabric Cloud Router Package like LAB, ADVANCED, STANDARD, PREMIUM"
  type        = string
}
variable "project_id" {
  description = "Subscriber-assigned project ID"
  type        = string
}
variable "account_number" {
  description = "Account number"
  type        = string
  sensitive   = true
}
variable "term_length" {
  description = "Term length in months"
  type        = number
}
