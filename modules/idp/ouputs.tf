output "idp_name_id_map" {
  value = zipmap([for idp in okta_idp_saml.idps: idp.name],[for idp in okta_idp_saml.idps: idp.id])
}