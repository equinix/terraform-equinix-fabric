variable "equinix_client_id" {
  description = "API Consumer Key available under 'My Apps' in developer portal"
  type        = string
}

variable "equinix_client_secret" {
  description = "API Consumer secret available under 'My Apps' in developer portal"
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "Equinix-assigned project ID the ASN is created in"
  type        = string
}

variable "metro_code" {
  description = "Two-letter metro code where the PRIVATE_ASN is provisioned"
  type        = string
}

variable "range" {
  description = "Range of the PRIVATE_ASN. One of: 16_BIT, 32_BIT"
  type        = string
}

variable "create" {
  description = "Create the resource. When false the example only runs search and get on existing data"
  type        = bool
  default     = true
}

variable "type" {
  description = "ASN type. One of: PRIVATE_ASN, PUBLIC_ASN"
  type        = string
}
