# Root module: deploys 3 RGs, 2 App Service Plans, 2 Windows Web Apps, 1 Traffic Manager.
# Dependency order: resource_group -> app_service_plan -> app_service -> traffic_manager.
# Merge global tags into per-resource tags for consistent tagging.
locals {
  resource_groups_with_tags = {
    for k, v in var.resource_groups : k => merge(v, { tags = merge(var.tags, v.tags) })
  }
  app_service_plans_with_tags = {
    for k, v in var.app_service_plan : k => merge(v, { tags = merge(var.tags, v.tags) })
  }

  app_services_for_module = {
    for k, v in var.app_service : k => {
      name                = v.name
      resource_group_name = v.resource_group_name
      location            = v.location
      service_plan_id     = module.app_service_plan.service_plan_ids[v.app_service_plan_key]
      tags                = merge(var.tags, v.tags)
    }
  }

  traffic_manager_profile = {
    name                   = var.traffic_manager.name
    resource_group_name    = module.resource_group.resource_groups[var.traffic_manager.rg_key].name
    relative_dns_name      = var.traffic_manager.relative_dns_name
    traffic_routing_method = var.traffic_manager.traffic_routing_method
    ttl                    = var.traffic_manager.ttl
    protocol               = var.traffic_manager.protocol
    port                   = var.traffic_manager.port
    path                   = var.traffic_manager.path
    tags                   = merge(var.tags, var.traffic_manager.tags)
  }
  traffic_manager_endpoints = {
    for k, id in module.app_service.web_app_ids : k => {
      name               = module.app_service.web_app_names[k]
      target_resource_id = id
      weight             = 1
      priority           = index(keys(module.app_service.web_app_ids), k) + 1
    }
  }
}

module "resource_group" {
  source = "./modules/resource_group"

  resource_groups = local.resource_groups_with_tags
}

module "app_service_plan" {
  source = "./modules/app_service_plan"

  app_service_plan = local.app_service_plans_with_tags
  depends_on       = [module.resource_group]
}

module "app_service" {
  source = "./modules/app_service"

  app_service  = local.app_services_for_module
  access_rules = var.access_rules
}

module "traffic_manager" {
  source = "./modules/traffic_manager"

  profile         = local.traffic_manager_profile
  azure_endpoints = local.traffic_manager_endpoints

  depends_on = [module.resource_group, module.app_service]
}
