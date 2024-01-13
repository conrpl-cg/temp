output "app_name_id_map" {
  value = zipmap([for app in okta_app_oauth.applications: app.label],[for app in okta_app_oauth.applications: app.id])
}