variable "create" {
  description = "Create the resource. When false nothing is created and get reads the first search result"
  type        = bool
  default     = true
}

variable "project_id" {
  description = "Equinix-assigned project ID the IP block belongs to"
  type        = string
}

variable "type" {
  description = "IP block type. One of: IPV4_IP_BLOCK, IPV6_IP_BLOCK"
  type        = string
  default     = "IPV4_IP_BLOCK"
}

variable "prefix_length" {
  description = "CIDR prefix length of the IP block (e.g. 30 for a /30 block)"
  type        = number
  default     = null
}

variable "location_metro_code" {
  description = "Two-letter metro code of the IP block (e.g. SV, DC, AM)"
  type        = string
  default     = null
}

variable "account_number" {
  description = "Billing account number of the IP block"
  type        = string
  default     = null
}

variable "search_filter_property" {
  description = "Field name used in the search filter"
  type        = string
  default     = "/project/projectId"
}

variable "search_filter_operator" {
  description = "Search filter operator"
  type        = string
  default     = "="
}

variable "search_filter_values" {
  description = "Values of the search filter. Defaults to [project_id] when null."
  type        = list(string)
  default     = null
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
