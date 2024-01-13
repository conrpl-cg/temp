module "admin_roles" {
    source = "./modules/admin_roles"
    roles_map = local.roles_map
}

module "authenticators" {
    source = "./modules/authenticators"
    authenticators_map = local.authenticators_map.authenticators
    mfa_policy = local.authenticators_map.mfa_policy
    group_name_id_map = module.groups.group_name_id_map
    depends_on = [ module.groups ]
}

module "authentication_policy" {
    source = "./modules/authentication_policy"
    policy_map = local.authentication_map.authentication_policy
    data_policy_map = local.authentication_map.authentication_policy_data
    authentication_rule = local.authentication_map.authentication_rule
    group_name_id_map = module.groups.group_name_id_map
    depends_on = [ module.groups ]
}

module "auth_server" {
    source = "./modules/auth_server"
    auth_server = local.auth_server_map.auth_server
    auth_server_policies = local.auth_server_map.auth_server_policies
    auth_server_policies_rules = local.auth_server_map.auth_server_policies_rules
    scopes = local.auth_server_map.scopes
    claims = local.auth_server_map.claims
    apps_name_id = module.applications.app_name_id_map
    groups_name_id = module.groups.group_name_id_map
    depends_on = [ module.applications, module.groups ]
}

module "groups" {
    source = "./modules/groups"
    group_map = local.group_map.group_map
}

module "assignments" {
    source = "./modules/assignments"
    group_name_id = module.groups.group_name_id_map
    apps_name_id = module.applications.app_name_id_map
    group_assignments = local.group_map.group_assignments
    depends_on = [ module.groups, module.applications ]
}

module "brand" {
    source = "./modules/brand"
    brand_map = local.brand_map.brand_map
    domains = local.brand_map.domains
    apps_name_id = module.applications.app_name_id_map
    depends_on = [ module.applications ]
}

module "signon" {
    source = "./modules/signon_policy"
    group_name_id_map = module.groups.group_name_id_map
    depends_on = [ module.groups ]
}

module "idp" {
    source = "./modules/idp"
    idp_map = local.idp_map.idp_map
    cert_map = local.idp_map.cert_map
    group_name_id_map = module.groups.group_name_id_map
    vision_cert = var.vision_cert
    depends_on = [ module.groups ]
}

module "profile_enrollment" {
  source = "./modules/profile_enrollment"
  profile_enrollment_map = local.profile_enrollment.profile_enrollment
  group_name-id_map = module.groups.group_name_id_map
  apps_name_id = module.applications.app_name_id_map
  depends_on = [ module.applications, module.groups ]
}

module "trusted_origin" {
    source = "./modules/trusted_origin"
    trusted_origin_map = local.trusted_origins_map.trusted_origin
}

module "applications" {
    source = "./modules/applications"
    apps_map = local.apps_map
    policy_name_id_map = module.authentication_policy.policy_name_id_map
    data_policy_name_id_map = module.authentication_policy.data_policy_name_id_map

    depends_on = [ module.authentication_policy ]
}

module "users" {
    source = "./modules/users"
    user_type = local.users.user_type
    user_schema_properties_map = local.users.attributes
    mappings_map = local.users.mapping
    idp_name_id_map = module.idp.idp_name_id_map

    depends_on = [ module.idp ]
}