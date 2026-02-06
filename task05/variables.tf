variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
  description = <<-EOT
    Map of resource groups to create. Each entry must have:
    - name: Resource group name
    - location: Azure region
    - tags: Tags (merged with global tags in root)
  EOT
}

variable "tags" {
  type        = map(string)
  description = "Global tags applied to all taggable resources."
}

variable "app_service_plan" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
    os_type             = string
    instance_count      = number
    tags                = map(string)
  }))
  description = <<-EOT
    Map of App Service Plans. Each entry must have:
    - name, resource_group_name, location, sku_name, os_type, instance_count, tags
  EOT
}

variable "app_service" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    app_service_plan_key = string
    tags                 = map(string)
  }))
  description = "Map of Windows Web Apps. app_service_plan_key references key in app_service_plan."
}

variable "allowed_ip_address" {
  type        = string
  description = "IP address of the verification agent for Web App access restrictions."
}

variable "access_rules" {
  type = list(object({
    name        = string
    priority    = number
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
  description = "IP restriction allow rules for all Web Apps (e.g. allow-ip, allow-tm)."
}

variable "traffic_manager" {
  type = object({
    rg_key                 = string
    name                   = string
    resource_group_name    = optional(string)
    relative_dns_name      = string
    traffic_routing_method = string
    ttl                    = number
    protocol               = string
    port                   = number
    path                   = string
    tags                   = map(string)
  })
  description = "Traffic Manager profile. rg_key = key in resource_groups for the RG to deploy TM. Endpoints are derived from Web Apps."
}
