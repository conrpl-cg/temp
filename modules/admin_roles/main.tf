resource "okta_admin_role_custom" "roles" {
  for_each = { for role in var.roles_map : role.name => role }

  label       = each.value.name
  description = each.value.description
  permissions = each.value.permissions
}
