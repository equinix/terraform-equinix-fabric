variable "route_aggregation_type" {
  description = "Type of the route aggregation policy. Should be one of: BGP_IPv4_PREFIX_ROUTE_AGGREGATION"
  type        = string
}

variable "route_aggregation_name" {
  description = "Name of the route aggregation policy that will be created in this module"
  type        = string
}

variable "route_aggregation_description" {
  description = "Description of the route aggregation policy you're creating"
  type        = string
  default     = ""
}

variable "route_aggregation_project_id" {
  description = "Project id where the route aggregation policy will be created. Should match the project id of the connection you would like to attach the route aggregation policy to"
  type        = string
}

variable "route_aggregation_rule_name" {
  description = "Name of the route aggregation rule that will be created in this module"
  type        = string
}

variable "route_aggregation_rule_description" {
  description = "Description of the route aggregation rule you're creating"
  type        = string
  default     = ""
}

variable "route_aggregation_rule_prefix" {
  description = "Route Aggregation prefix Rule"
  type        = string
}

variable "connection_id" {
  description = "Id of the Fabric connection you want to attach the route filter policy to"
  type        = string
}
