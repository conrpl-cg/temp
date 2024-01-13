variable "user_type" {
    description = "Map of Users type"
    default = {}
}

variable "user_schema_properties_map" {
  description = "A map with User schema properties"
  default     = {}
}

variable "mappings_map" {
  description = "The maaping configuration"
  default     = {}
}

variable "idp_name_id_map" {
  description = "The maaping idp and names"
  default     = {}
  
}
