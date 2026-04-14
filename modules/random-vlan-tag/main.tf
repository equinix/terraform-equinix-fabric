resource "random_integer" "vlan_tag" {
  min = var.min
  max = var.max
}
