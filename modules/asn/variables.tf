variable "create" {
  description = "Create the resource. When false nothing is created and get reads the first search result"
  type        = bool
  default     = true
}

variable "project_id" {
  description = "Equinix-assigned project ID the ASN belongs to"
  type        = string
}

variable "type" {
  description = "ASN type. One of: PRIVATE_ASN, PUBLIC_ASN"
  type        = string
  default     = "PRIVATE_ASN"
}

variable "location_metro_code" {
  description = "Two-letter metro code of a PRIVATE_ASN (e.g. SV, DC, AM)"
  type        = string
  default     = null
}

variable "range" {
  description = "Range of a PRIVATE_ASN. One of: 16_BIT, 32_BIT"
  type        = string
  default     = null
}

variable "number" {
  description = "Autonomous System Number. Required for a PUBLIC_ASN; assigned by Equinix for a PRIVATE_ASN"
  type        = number
  default     = null
}

variable "rir_region" {
  description = "Regional Internet Registry region of a PUBLIC_ASN. One of: AFRINIC, APNIC, ARIN, LACNIC, RIPE_NCC"
  type        = string
  default     = null
}

variable "ownership_challenge_type" {
  description = "Ownership challenge type of a PUBLIC_ASN. One of: RPKI, LOA"
  type        = string
  default     = null
}

variable "ownership_challenge_signature" {
  description = "Signed ownership challenge of a PUBLIC_ASN. Can be set at creation or updated in place"
  type        = string
  default     = null
  sensitive   = true
}

variable "search_filter_property" {
  description = "Field name used in the search filter"
  type        = string
  default     = "/state"
}

variable "search_filter_operator" {
  description = "Search filter operator"
  type        = string
  default     = "="
}

variable "search_filter_values" {
  description = "Values of the search filter. "
  type        = list(string)
  default     = ["PROVISIONED"]
}

variable "search_pagination_limit" {
  description = "Maximum number of search results per page (1-100)"
  type        = number
  default     = 20
}

variable "search_pagination_offset" {
  description = "Index of the first search result"
  type        = number
  default     = 0
}

variable "search_sort_property" {
  description = "Search sort property. Set to null to use the API default"
  type        = string
  default     = "/changeLog/createdDateTime"
}

variable "search_sort_direction" {
  description = "Search sort direction: ASC or DESC"
  type        = string
  default     = "DESC"
}
