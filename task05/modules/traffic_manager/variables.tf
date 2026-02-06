variable "profile" {
  type = object({
    name                   = string
    resource_group_name    = string
    relative_dns_name      = string
    traffic_routing_method = string
    ttl                    = number
    protocol               = string
    port                   = number
    path                   = string
    tags                   = map(string)
  })
  description = "Traffic Manager profile configuration. path is the relative path for health checks (e.g. \"/\")."
}

variable "azure_endpoints" {
  type = map(object({
    name               = string
    target_resource_id = string
    weight             = optional(number)
    priority           = optional(number)
  }))
  description = "Map of Azure endpoints (e.g. Web App IDs). weight and priority optional."
}
