resource "okta_trusted_origin" "trusted_origin" {
    for_each = { for trusted_origin in var.trusted_origin_map : trusted_origin.name => trusted_origin}

    name   = each.value.name
    origin = each.value.origin
    scopes = each.value.scopes
}