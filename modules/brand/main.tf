resource "okta_brand" "capgroup" {
  for_each = { for brand in var.brand_map : brand.name => brand }

  name                        = each.value.name
  remove_powered_by_okta      = each.value.remove_powered_by_okta
  default_app_app_instance_id = try(var.apps_name_id[each.value.defaul_app],null)
}

resource "okta_theme" "capitalgroup" {
  for_each = { for brand in var.brand_map : brand.name => brand }

  brand_id                               = okta_brand.capgroup[each.value.name].id
  logo                                   = each.value.logo
  sign_in_page_touch_point_variant       = each.value.signInPageTouchPointVariant
  end_user_dashboard_touch_point_variant = each.value.endUserDashboardTouchPointVariant
  error_page_touch_point_variant         = each.value.errorPageTouchPointVariant
  email_template_touch_point_variant     = each.value.emailTemplateTouchPointVariant
  primary_color_contrast_hex             = each.value.primaryColorContrastHex
  primary_color_hex                      = each.value.primaryColorHex
  secondary_color_contrast_hex           = each.value.secondaryColorContrastHex
  secondary_color_hex                    = each.value.secondaryColorHex
}

resource "okta_email_customization" "capitalgroup_templates" {
  for_each = { for template in var.brand_map[0].template_email : template.template_name => template }

  brand_id      = okta_brand.capgroup[var.brand_map[0].name].id
  template_name = each.value.template_name
  is_default    = each.value.is_default
  language      = each.value.language
  subject       = each.value.subject
  body          = each.value.body
}

resource "okta_domain" "domain" {
  for_each = { for domain in var.domains : domain.name => domain }

  name                    = each.value.url
  certificate_source_type = each.value.certificateSourceType

  lifecycle {
    ignore_changes = [ certificate_source_type ]
  }
}


