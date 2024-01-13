resource "okta_idp_saml_key" "certificate" {
  for_each = { for cert in var.cert_map : cert.name => cert }
  x5c      = each.value.name == "vision"?[var.vision_cert]:[]
}

resource "okta_idp_saml" "idps" {
  for_each                 = { for idp in var.idp_map : idp.name => idp }
  name                     = each.value.name
  acs_type                 = "INSTANCE"
  sso_url                  = each.value.sso_url
  sso_destination          = each.value.sso_destination
  sso_binding              = "HTTP-POST"
  username_template        = each.value.usernameTemplate
  kid                      = okta_idp_saml_key.certificate[each.value.certificate].id
  issuer                   = each.value.issuer
  request_signature_scope  = "REQUEST"
  response_signature_scope = "ANY"
  profile_master           = each.value.profileMaster
  max_clock_skew           = each.value.maxClockSkew
  groups_action            = "ASSIGN"
  groups_assignment        = [for group in each.value.groups : var.group_name_id_map[group]]
  issuer_mode = ""
  name_format = ""
}
