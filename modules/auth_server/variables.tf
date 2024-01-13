variable "auth_server" {
    description = "Authorization Server"
    default = {}
}

variable "auth_server_policies" {
  description = "Policies"
  default = {}
}

variable "auth_server_policies_rules" {
  description = "Policies rules"
  default = {}
}

variable "apps_name_id" {
  description = "Map of Name and id of applications"
  default = {}
}

variable "groups_name_id" {
  description = "Map of Name and id of groups"
  default = {}
}

variable "scopes" {
  description = "Scopes"
  default = {}
}

variable "claims" {
  description = "Claims"
  default = {}
}