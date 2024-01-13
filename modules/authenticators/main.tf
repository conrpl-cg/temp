/*resource "cgokta_authenticator" "authenticators" {
  for_each = { for authenticators in var.authenticators_map : authenticators.name => authenticators }

  name                        = each.value.name
  key                         = each.value.key
  status                      = each.value.status
  settings                    = try(jsonencode(each.value.settings),null)

  lifecycle {
    ignore_changes = [ 
      provider_hostname,
      provider_user_name_template
     ]
  }
}*/

resource "okta_authenticator" "authenticators" {
  for_each = { for authenticators in var.authenticators_map : authenticators.name => authenticators }

  name                        = each.value.name
  key                         = each.value.key
  status                      = each.value.status
  settings                    = try(jsonencode(each.value.settings),null)

  lifecycle {
    ignore_changes = [ 
      provider_hostname,
      provider_user_name_template
     ]
  }
}

resource "okta_policy_mfa" "bdd_enrollment" {
  name        = var.mfa_policy.bdd_enrollment.name
  status      = "ACTIVE"
  description = var.mfa_policy.bdd_enrollment.description
  is_oie      = true

  okta_password = {
    enroll = "REQUIRED"
  }

  security_question = {
    enroll = "REQUIRED"
  }

  groups_included = [var.group_name_id_map["ROLE_BDD_AUTOMATION"]]

  depends_on = [okta_authenticator.authenticators]
}

resource "okta_policy_rule_mfa" "bdd_enrollment" {
  policy_id = okta_policy_mfa.bdd_enrollment.id
  name      = var.mfa_policy.bdd_enrollment.rule.name
  status    = "ACTIVE"
  enroll    = "CHALLENGE"
}

resource "okta_policy_mfa" "oidc_enrollment" {
  name        = var.mfa_policy.oidc_enrollment.name
  status      = "ACTIVE"
  description = var.mfa_policy.oidc_enrollment.description
  is_oie      = true

  okta_password = {
    enroll = "REQUIRED"
  }

  security_question = {
    enroll = "NOT_ALLOWED"
  }

  okta_verify = {
    enroll = "NOT_ALLOWED"
  }

  groups_included = [
    var.group_name_id_map["Investors MFA Group"],
    var.group_name_id_map["ROLE_INVESTOR"]
  ]

  depends_on = [okta_authenticator.authenticators]
}

resource "okta_policy_rule_mfa" "oidc_enrollment" {
  policy_id = okta_policy_mfa.oidc_enrollment.id
  name      = var.mfa_policy.oidc_enrollment.rule.name
  status    = "ACTIVE"
  enroll    = "CHALLENGE"
}

resource "okta_policy_mfa" "advisor_enrollment" {
  name        = var.mfa_policy.advisor_enrollment.name
  status      = "ACTIVE"
  description = var.mfa_policy.advisor_enrollment.description
  is_oie      = true

  okta_password = {
    enroll = "REQUIRED"
  }

  security_question = {
    enroll = "NOT_ALLOWED"
  }

  okta_verify = {
    enroll = "NOT_ALLOWED"
  }

  groups_included = [
    var.group_name_id_map["ROLE_ADVISOR"]
  ]

  depends_on = [okta_authenticator.authenticators]
}

resource "okta_policy_rule_mfa" "advisor_enrollment" {
  policy_id = okta_policy_mfa.advisor_enrollment.id
  name      = var.mfa_policy.advisor_enrollment.rule.name
  status    = "ACTIVE"
  enroll    = "CHALLENGE"
}

resource "okta_policy_mfa" "advisor_saml_enrollment" {
  name        = var.mfa_policy.advisor_saml_enrollment.name
  status      = "ACTIVE"
  description = var.mfa_policy.advisor_saml_enrollment.description
  is_oie      = true

  okta_password = {
    enroll = "REQUIRED"
  }

  security_question = {
    enroll = "NOT_ALLOWED"
  }

  okta_verify = {
    enroll = "NOT_ALLOWED"
  }

  groups_included = [
    var.group_name_id_map["ROLE_ADVISOR_DASHBOARD"],
    var.group_name_id_map["ROLE_ADVISOR_VISION"]
  ]

  depends_on = [okta_authenticator.authenticators]
}

resource "okta_policy_rule_mfa" "advisor_saml_enrollment" {
  policy_id = okta_policy_mfa.advisor_saml_enrollment.id
  name      = var.mfa_policy.advisor_saml_enrollment.rule.name
  status    = "ACTIVE"
  enroll    = "CHALLENGE"
}
