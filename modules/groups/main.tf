resource "okta_group" "groups" {
  for_each = { for group in var.group_map : group.name => group }

  name        = each.value.name
  description = each.value.description
}
