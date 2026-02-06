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
  description = "Map of App Service Plans to create."
}
