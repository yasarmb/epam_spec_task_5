resource "azurerm_service_plan" "main" {
  for_each = var.app_service_plan

  name                         = each.value.name
  location                     = each.value.location
  resource_group_name          = each.value.resource_group_name
  os_type                      = each.value.os_type
  sku_name                     = each.value.sku_name
  worker_count                 = each.value.instance_count
  tags                         = each.value.tags
  maximum_elastic_worker_count = startswith(upper(each.value.sku_name), "EP") ? each.value.instance_count : null
}
