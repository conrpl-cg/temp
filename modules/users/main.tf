resource "okta_user_type" "user_type" {
  for_each = { for ut in var.user_type : ut.name => ut }

  name         = each.value.name
  display_name = each.value.displayName
  description  = each.value.description
}

resource "okta_profile_mapping" "mappings" {
  for_each = { for mapping in var.mappings_map : mapping.nameId => mapping }

  source_id          = var.idp_name_id_map[each.value.source]
  target_id          = okta_user_type.user_type[each.value.target].id
  delete_when_absent = each.value.delete

  dynamic "mappings" {
    for_each = each.value.attributes
    content {
      id     = mappings.value.id
      expression    = mappings.value.expression
      push_status = mappings.value.pushStatus
    }
  }
}

resource "okta_user_base_schema_property" "other_user_base_schema_property" {
  for_each = { for property in var.user_schema_properties_map.others : property.index => property }

  index       = each.value.index
  title       = each.value.title
  type        = each.value.type
  required    = each.value.required
  master      = each.value.master
  permissions = each.value.permissions
  user_type   = okta_user_type.user_type[each.value.userType].id
}
