resource "okta_app_group_assignments" "assignments" {
  for_each = { for assignment in var.group_assignments : assignment.name => assignment }

  app_id = var.apps_name_id[each.value.app_name]
  dynamic "group" {
    for_each = each.value.groups
    content {
      id       = var.group_name_id[group.value.name]
      priority = group.value.priority
    }
  }

}
