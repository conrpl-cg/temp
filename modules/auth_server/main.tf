resource "okta_auth_server" "server" {
  for_each    = { for auth_server in var.auth_server : auth_server.name => auth_server }
  audiences   = each.value.audiences
  description = each.value.description
  name        = each.value.name
  issuer_mode = each.value.issuerMode
  status      = each.value.status
}

resource "okta_auth_server_scope" "scope" {
  for_each = { for scopes in var.scopes : scopes.identify => scopes }

  auth_server_id   = okta_auth_server.server[each.value.parent].id
  name             = each.value.name
  display_name     = each.value.displayName
  consent          = each.value.consent
  metadata_publish = each.value.metadataPublish
}

resource "okta_auth_server_claim" "claim" {
  for_each = { for claim in var.claims : claim.key => claim }

  auth_server_id          = okta_auth_server.server[each.value.parent].id
  name                    = each.value.name
  value                   = each.value.value
  status                  = each.value.status
  scopes                  = each.value.scopes
  value_type              = each.value.valueType
  claim_type              = each.value.claimType
  always_include_in_token = each.value.alwaysIncludeInToken
  group_filter_type       = each.value.groupFilterType
}

resource "okta_auth_server_policy" "policy" {
  for_each = { for policy in var.auth_server_policies : policy.name => policy }

  auth_server_id   = okta_auth_server.server[each.value.parent].id
  status           = each.value.status
  name             = each.value.name
  description      = each.value.description
  priority         = each.value.priority
  client_whitelist = [for app in each.value.ref : var.apps_name_id[app]]
}

resource "okta_auth_server_policy_rule" "rule" {
  for_each = { for rule in var.auth_server_policies_rules : rule.name => rule }

  auth_server_id                 = okta_auth_server.server[each.value.authServerParent].id
  policy_id                      = okta_auth_server_policy.policy[each.value.policyParent].id
  status                         = each.value.status
  name                           = each.value.name
  priority                       = each.value.priority
  grant_type_whitelist           = each.value.grantTypeWhitelist
  scope_whitelist                = each.value.scopeWhitelist
  access_token_lifetime_minutes  = each.value.accessTokenLifetimeMinutes
  refresh_token_lifetime_minutes = each.value.refreshTokenLifetimeMinutes
  refresh_token_window_minutes   = each.value.refreshTokenWindowMinutes
  group_whitelist           = [for group in each.value.group_whitelist : group=="EVERYONE"?"EVERYONE":var.groups_name_id[group]]

  depends_on = [okta_auth_server_scope.scope["system_investor"]]
}
