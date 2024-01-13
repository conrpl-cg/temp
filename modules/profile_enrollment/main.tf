resource "okta_policy_profile_enrollment" "profile_enrollment" {
  for_each = { for enrollment in var.profile_enrollment_map : enrollment.name => enrollment }

  name   = each.value.name
  status = "ACTIVE"
}

resource "okta_policy_rule_profile_enrollment" "profile_enrollment_rule" {
  for_each = { for enrollment in var.profile_enrollment_map : enrollment.name => enrollment }

  policy_id          = okta_policy_profile_enrollment.profile_enrollment[each.value.name].id
  target_group_id    = try(var.group_name-id_map[each.value.rule.target_group_name], null)
  email_verification = each.value.rule.email_verification

  unknown_user_action          = each.value.rule.unknownUserAction
  access                       = each.value.rule.access
  progressive_profiling_action = each.value.rule.progressiveProfilingAction
  ui_schema_id                 = each.value.rule.uiSchemaId

  dynamic "profile_attributes" {
    for_each = each.value.rule.profile_attributes
    content {
      name     = profile_attributes.value.name
      label    = profile_attributes.value.label
      required = profile_attributes.value.required
    }
  }
}

resource "okta_policy_profile_enrollment_apps" "profile_enrollment_apps" {
  for_each = { for enrollment in var.profile_enrollment_map : enrollment.name => enrollment }

  policy_id = okta_policy_profile_enrollment.profile_enrollment[each.value.name].id
  apps      = [for app_label in each.value.apps : var.apps_name_id[app_label]]
}
