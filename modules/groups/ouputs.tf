output "group_name_id_map" {
  value = zipmap([for group in okta_group.groups: group.name],[for group in okta_group.groups: group.id])
}