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
variable "connection_id" {
  description = "Connection ID. The unique identifier for the connection"
  type        = string
}
variable "types" {
  description = "Array of route types to filter the received routes. Possible values are: \"IPv4_BGP_ROUTE\" \"IPv4_STATIC_ROUTE\" \"IPv4_DIRECT_ROUTE\" \"IPv6_BGP_ROUTE\" \"IPv6_STATIC_ROUTE\" \"IPv6_DIRECT_ROUTE\""
  type        = list(string)
}
