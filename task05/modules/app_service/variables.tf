variable "app_service" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    service_plan_id     = string
    tags                = map(string)
  }))
  description = "Map of Windows Web Apps to create."
}

# Single list: each rule has name, priority, and optionally ip_address and/or service_tag
variable "access_rules" {
  type = list(object({
    name        = string
    priority    = number
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
  description = "IP restriction allow rules; ip_address normalized to /32 if plain IP."
}
