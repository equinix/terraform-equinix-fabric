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
  description = "Equinix-assigned project ID the IP block is created in"
  type        = string
}

variable "metro_code" {
  description = "Two-letter metro code where the IP block is provisioned"
  type        = string
}

variable "type" {
  description = "IP block type. One of: IPV4_IP_BLOCK, IPV6_IP_BLOCK"
  type        = string
}

variable "prefix_length" {
  description = "CIDR prefix length of the IP block"
  type        = number
}

variable "account_number" {
  description = "Billing account number (optional)"
  type        = string
}

variable "create" {
  description = "Create the resource. When false the example only runs search and get on existing data"
  type        = bool
  default     = true
}
