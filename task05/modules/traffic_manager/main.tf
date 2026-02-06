resource "azurerm_traffic_manager_profile" "main" {
  name                   = var.profile.name
  resource_group_name    = var.profile.resource_group_name
  traffic_routing_method = var.profile.traffic_routing_method
  profile_status         = "Enabled"
  tags                   = var.profile.tags

  dns_config {
    relative_name = var.profile.relative_dns_name
    ttl           = var.profile.ttl
  }

  monitor_config {
    protocol = var.profile.protocol
    port     = 80
    path     = "/"
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "main" {
  for_each = var.azure_endpoints

  name               = each.value.name
  profile_id         = azurerm_traffic_manager_profile.main.id
  target_resource_id = each.value.target_resource_id
  weight             = try(each.value.weight, null)
  priority           = try(each.value.priority, null)
}
