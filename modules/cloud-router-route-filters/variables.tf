variable "route_filter_policy_name" {
  description = "Name of the route filter policy that will be created in this module"
  type = string
}

variable "route_filter_policy_project_id" {
  description = "Project id where the route filter policy will be created. Should match the project id of the connection you would like to attach the route filter policy to"
  type = string
}

variable "route_filter_policy_type" {
  description = "Type of the route filter policy. Should be one of: BGP_IPv4_PREFIX_FILTER, BGP_IPv6_PREFIX_FILTER"
  type = string
}

variable "route_filter_policy_description" {
  description = "Description of the route filter policy you're creating"
  type = string
  default = ""
}

variable "route_filter_rules" {
  description = "List of route filter rules to add to the created route filter policy"
  type        = list(object({
    prefix = string,
    name = optional(string),
    description = optional(string),
    prefix_match = optional(string),
  }))
}

variable "connection_route_filter_direction" {
  description = "Direction [INBOUND or OUTBOUND] that the route filter policy is applied to for the connection"
  type = string
}

variable "connection_id" {
  description = "Id of the Fabric connection you want to attach the route filter policy to"
  type = string
}
