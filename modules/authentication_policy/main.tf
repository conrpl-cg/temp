resource "okta_app_signon_policy" "app_signon_policy" {
  for_each = { for policy in var.policy_map : policy.name => policy }

  name        = each.value.name
  description = each.value.description
}

data "okta_policy" "policy" {
  for_each = { for policy in var.data_policy_map : policy.name => policy }

  name = each.value.name
  type = "ACCESS_POLICY"
}

resource "okta_app_signon_policy_rule" "totp-mfa-rule" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Password + TOTP"].id
  name                        = "TOTP & MFA"
  re_authentication_frequency = "PT43800H"
  priority                    = 1
  inactivity_period           = ""
  groups_excluded             = [var.group_name_id_map["ROLE_ADMIN"]]
  groups_included             = [var.group_name_id_map["ROLE_INVESTOR"]]
  constraints = [
    jsonencode(
      {
        knowledge = {
          reauthenticateIn = "PT2H"
          types            = ["password"]
        }
        possession = {
          deviceBound = "REQUIRED"
        }
      }
    ),
  ]
}

/*resource "okta_app_signon_policy_rule" "totp-mfa-rule-catch-all" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Password + TOTP"].id
  name                        = "Catch-all Rule"
  re_authentication_frequency = "PT12H"
  inactivity_period           = ""
  access                      = "DENY"
  risk_score                  = ""
  constraints = [
    jsonencode(
      {
        possession = {
          deviceBound = "REQUIRED"
        }
      }
    ),
  ]
}*/

/*resource "okta_app_signon_policy_rule" "qa-one-factor-access-rule-catch-all" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Password-1FA QA"].id
  name                        = "Catch-all Rule"
  re_authentication_frequency = "PT43800H"
  inactivity_period           = ""
  access                      = "ALLOW"
  network_connection          = ""
  factor_mode                 = "1FA"
  risk_score                  = ""
  constraints = [
    jsonencode(
      {
        knowledge = {
          types = ["password"]
        }
      }
    ),
  ]

}*/

/*resource "okta_app_signon_policy_rule" "any_two-catchall" {
  policy_id                   = data.okta_policy.policy["Any two factors"].id
  name                        = var.authentication_rule.any_two-catchall.name
  factor_mode                 = var.authentication_rule.any_two-catchall.factorMode
  re_authentication_frequency = var.authentication_rule.any_two-catchall.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.any_two-catchall.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.any_two-catchall.priority
  groups_included             = [for group_label in var.authentication_rule.any_two-catchall.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.any_two-catchall.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}*/

resource "okta_app_signon_policy_rule" "advisor_dashboard_saml-rule" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Advisor Dashboard SAML Policy"].id
  name                        = var.authentication_rule.advisor_dashboard_saml-rule.name
  factor_mode                 = var.authentication_rule.advisor_dashboard_saml-rule.factorMode
  re_authentication_frequency = var.authentication_rule.advisor_dashboard_saml-rule.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.advisor_dashboard_saml-rule.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.advisor_dashboard_saml-rule.priority
  groups_included             = [for group_label in var.authentication_rule.advisor_dashboard_saml-rule.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.advisor_dashboard_saml-rule.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}

/*resource "okta_app_signon_policy_rule" "advisor_dashboard_saml-catchall" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Advisor Dashboard SAML Policy"].id
  name                        = var.authentication_rule.advisor_dashboard_saml-catchall.name
  factor_mode                 = var.authentication_rule.advisor_dashboard_saml-catchall.factorMode
  re_authentication_frequency = var.authentication_rule.advisor_dashboard_saml-catchall.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.advisor_dashboard_saml-catchall.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.advisor_dashboard_saml-catchall.priority
  groups_included             = [for group_label in var.authentication_rule.advisor_dashboard_saml-catchall.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.advisor_dashboard_saml-catchall.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}*/

resource "okta_app_signon_policy_rule" "advisor_vision_saml-rule" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Advisor Vision Saml Policy"].id
  name                        = var.authentication_rule.advisor_vision_saml-rule.name
  factor_mode                 = var.authentication_rule.advisor_vision_saml-rule.factorMode
  re_authentication_frequency = var.authentication_rule.advisor_vision_saml-rule.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.advisor_vision_saml-rule.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.advisor_vision_saml-rule.priority
  groups_included             = [for group_label in var.authentication_rule.advisor_vision_saml-rule.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.advisor_vision_saml-rule.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}

/*resource "okta_app_signon_policy_rule" "advisor_vision_saml-catchall" {
  policy_id                   = okta_app_signon_policy.app_signon_policy["Advisor Vision Saml Policy"].id
  name                        = var.authentication_rule.advisor_vision_saml-catchall.name
  factor_mode                 = var.authentication_rule.advisor_vision_saml-catchall.factorMode
  re_authentication_frequency = var.authentication_rule.advisor_vision_saml-catchall.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.advisor_vision_saml-catchall.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.advisor_vision_saml-catchall.priority
  groups_included             = [for group_label in var.authentication_rule.advisor_vision_saml-catchall.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.advisor_vision_saml-catchall.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}*/

resource "okta_app_signon_policy_rule" "dip-parent-rule" {
  policy_id                   = okta_app_signon_policy.app_signon_policy[var.authentication_rule.dip-parent-rule.name_parent].id
  name                        = var.authentication_rule.dip-parent-rule.name
  factor_mode                 = var.authentication_rule.dip-parent-rule.factorMode
  re_authentication_frequency = var.authentication_rule.dip-parent-rule.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.dip-parent-rule.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.dip-parent-rule.priority
  groups_included             = [for group_label in var.authentication_rule.dip-parent-rule.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.dip-parent-rule.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}

/*resource "okta_app_signon_policy_rule" "dip-parent-catchall" {
  policy_id                   = okta_app_signon_policy.app_signon_policy[var.authentication_rule.dip-parent-catchall.name_parent].id
  name                        = var.authentication_rule.dip-parent-catchall.name
  factor_mode                 = var.authentication_rule.dip-parent-catchall.factorMode
  re_authentication_frequency = var.authentication_rule.dip-parent-catchall.reauthenticateIn
  constraints                 = [for constraint in var.authentication_rule.dip-parent-catchall.constraints : jsonencode(constraint)]
  priority                    = var.authentication_rule.dip-parent-catchall.priority
  groups_included             = [for group_label in var.authentication_rule.dip-parent-catchall.groups : var.group_name_id_map[group_label]]
  access                      = var.authentication_rule.dip-parent-catchall.access

  lifecycle {
    ignore_changes = [
      inactivity_period,
      network_connection,
      risk_score
    ]
  }
}*/
