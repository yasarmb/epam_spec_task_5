# Normalize IP to CIDR when present (e.g. 1.2.3.4 -> 1.2.3.4/32)
locals {
  normalized_rules = [
    for r in var.access_rules : merge(r, {
      ip_address = try(r.ip_address, null) != null && !can(regex("/", r.ip_address)) ? "${r.ip_address}/32" : try(r.ip_address, null)
    })
  ]
}

resource "azurerm_windows_web_app" "main" {
  for_each = var.app_service

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  service_plan_id     = each.value.service_plan_id
  tags                = each.value.tags

  site_config {
    always_on                     = true
    http2_enabled                 = true
    minimum_tls_version           = "1.2"
    ip_restriction_default_action = "Deny"

    dynamic "ip_restriction" {
      for_each = local.normalized_rules
      content {
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        action      = "Allow"
        ip_address  = try(ip_restriction.value.ip_address, null)
        service_tag = try(ip_restriction.value.service_tag, null)
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
