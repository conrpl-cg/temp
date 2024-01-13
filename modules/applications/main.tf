resource "okta_app_oauth" "applications" {
  for_each                   = { for app in var.apps_map : app.name => app }
  label                      = each.value.name
  type                       = each.value.type
  status                     = each.value.status
  grant_types                = each.value.grantTypes
  response_types             = each.value.responseTypes
  pkce_required              = each.value.pkceRequired
  token_endpoint_auth_method = each.value.authMethod
  authentication_policy      = try(each.value.policyType == "data" ? var.data_policy_name_id_map[each.value.policyName] : var.policy_name_id_map[each.value.policyName], "")
  login_uri                  = try(each.value.loginURI, "")
  omit_secret                = false
  issuer_mode                = "DYNAMIC"
  post_logout_redirect_uris  = each.value.logoutRedirect
  redirect_uris              = each.value.redirectURIs
  profile                    = jsonencode(each.value.profile)
  refresh_token_leeway       = each.value.refreshTokenLeeway
  refresh_token_rotation     = each.value.refreshTokenRotation
  consent_method             = try(each.value.consentMethod, null)

  dynamic "groups_claim" {
    for_each = each.value.groupsClaim

    content {
      filter_type = groups_claim.value.filterType
      name        = groups_claim.value.name
      type        = groups_claim.value.type
      value       = groups_claim.value.value
    }
  }
}
