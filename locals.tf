locals {

    roles_map  = concat(jsondecode(file("./input_files/config/admin_roles.json")), jsondecode(file("./input_files/${var.target_env_name}/admin_roles.json")))

    apps_map  = concat(jsondecode(file("./input_files/config/applications.json")), jsondecode(file("./input_files/${var.target_env_name}/applications.json")))

    authenticators_map  = jsondecode(file("./input_files/config/authenticators.json"))
    
    authentication_map  = jsondecode(file("./input_files/config/authentication.json"))
    
    auth_server_map  = jsondecode(file("./input_files/config/auth_server.json"))

    brand_map = jsondecode(file("./input_files/config/brand.json"))

    idp_map = jsondecode(file("./input_files/config/idp.json"))

    profile_enrollment = jsondecode(file("./input_files/config/profile_enrollment.json"))

    group_map = jsondecode(file("./input_files/config/group.json"))

    trusted_origins_map = jsondecode(file("./input_files/config/trusted-origin.json"))

    users = jsondecode(file("./input_files/config/user.json"))
}

