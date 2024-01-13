resource "okta_policy_signon" "signon_qa-bdd" {

  name            = "QA/BDD Global Policy"
  status          = "ACTIVE"
  description     = "Policy for QA users and BDD automation testing."
  priority        = 1
  groups_included = [var.group_name_id_map["ROLE_BDD_AUTOMATION"]]
}

resource "okta_policy_rule_signon" "signon_qa-bdd" {
  policy_id        = okta_policy_signon.signon_qa-bdd.id
  name             = "QA/BDD Automation Session Rule"
  status           = "ACTIVE"
  priority         = 1
  mfa_required     = true
  primary_factor   = "PASSWORD_IDP"
  mfa_prompt       = "ALWAYS"
  session_lifetime = 20
  session_idle     = 20
}

resource "okta_policy_signon" "signon_investors" {
  name            = "Investors MFA Policy"
  status          = "ACTIVE"
  description     = "Investors MFA Policy"
  priority        = 2
  groups_included = [var.group_name_id_map["Investors MFA Group"]]
  depends_on      = [okta_policy_signon.signon_qa-bdd]
}

resource "okta_policy_rule_signon" "signon_investors" {
  policy_id        = okta_policy_signon.signon_investors.id
  name             = "Investors MFA Rule"
  status           = "ACTIVE"
  priority         = 1
  mfa_required     = true
  primary_factor   = "PASSWORD_IDP_ANY_FACTOR"
  mfa_prompt       = "ALWAYS"
  session_lifetime = 20
  session_idle     = 20
}

resource "okta_policy_signon" "signon_role-investors" {
  name            = "ROLE INVESTOR Policy"
  status          = "ACTIVE"
  description     = "ROLE INVESTOR Policy"
  priority        = 3
  groups_included = [var.group_name_id_map["ROLE_INVESTOR"]]
  depends_on      = [okta_policy_signon.signon_investors]
}

resource "okta_policy_rule_signon" "signon_role-investors" {
  policy_id        = okta_policy_signon.signon_role-investors.id
  name             = "ROLE INVESTOR Policy"
  status           = "ACTIVE"
  priority         = 1
  mfa_required     = true
  primary_factor   = "PASSWORD_IDP_ANY_FACTOR"
  mfa_prompt       = "ALWAYS"
  session_lifetime = 20
  session_idle     = 20
}

resource "okta_policy_signon" "advisor_dashboard_vision" {
  name            = "Advisor Dashboard & Vision Global Session Policies"
  status          = "ACTIVE"
  description     = "Advisor Dashboard & Vision Global Session Policies"
  priority        = 4
  groups_included = [var.group_name_id_map["ROLE_ADVISOR_DASHBOARD"], var.group_name_id_map["ROLE_ADVISOR_VISION"]]
  depends_on      = [okta_policy_signon.signon_role-investors]
}

resource "okta_policy_rule_signon" "advisor_dashboard_vision" {
  policy_id        = okta_policy_signon.advisor_dashboard_vision.id
  name             = "Advisor Dashboard Access Rule"
  status           = "ACTIVE"
  priority         = 1
  mfa_required     = false
  primary_factor   = "PASSWORD_IDP_ANY_FACTOR"
  session_lifetime = 0
  session_idle     = 20
}

resource "okta_policy_signon" "advisor_global" {
  name            = "Advisor Global Session Policy"
  status          = "ACTIVE"
  description     = "Advisor Marketing Global Session Policy"
  priority        = 5
  groups_included = [var.group_name_id_map["ROLE_ADVISOR"]]
  depends_on      = [okta_policy_signon.advisor_dashboard_vision]
}

resource "okta_policy_rule_signon" "advisor_global" {
  policy_id          = okta_policy_signon.advisor_global.id
  name               = "POC-Advisor Global Session Rule"
  status             = "ACTIVE"
  priority           = 1
  mfa_required       = false
  primary_factor     = "PASSWORD_IDP_ANY_FACTOR"
  session_lifetime   = 43200
  session_idle       = 43200
  session_persistent = true
}

resource "okta_policy_signon" "signon_admin" {
  name            = "Admin Policy"
  status          = "ACTIVE"
  description     = ""
  priority        = 6
  groups_included = [var.group_name_id_map["ROLE_ADMIN"]]
  depends_on      = [okta_policy_signon.advisor_global]
}

resource "okta_policy_rule_signon" "signon_admin" {
  policy_id        = okta_policy_signon.signon_admin.id
  name             = "Admin Rule"
  status           = "ACTIVE"
  priority         = 1
  mfa_required     = true
  primary_factor   = "PASSWORD_IDP_ANY_FACTOR"
  mfa_prompt       = "ALWAYS"
  session_lifetime = 43200
  session_idle     = 10080
}

resource "okta_policy_signon" "default" {
  name            = "Default Policy"
  status          = "ACTIVE"
  description     = "The default policy applies in all situations if no other policy applies."
  priority        = 7
  groups_included = [var.group_name_id_map["Everyone"]]
  depends_on      = [okta_policy_signon.signon_admin]
}

resource "okta_policy_rule_signon" "default" {
  policy_id         = okta_policy_signon.default.id
  name              = "Default Rule"
  status            = "ACTIVE"
  priority          = 1
  mfa_required      = true
  primary_factor    = "PASSWORD_IDP_ANY_FACTOR"
  mfa_prompt        = "ALWAYS"
  session_lifetime  = 0
  session_idle      = 20
  risc_level = ""
  identity_provider = ""
}
