output "policy_name_id_map" {
  value = zipmap([for policy in okta_app_signon_policy.app_signon_policy: policy.name],[for policy in okta_app_signon_policy.app_signon_policy: policy.id])
}

output "data_policy_name_id_map" {
  value = zipmap([for policy in data.okta_policy.policy: policy.name],[for policy in data.okta_policy.policy: policy.id])
}