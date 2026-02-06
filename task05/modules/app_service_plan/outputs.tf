output "service_plan_ids" {
  description = "Map of App Service Plan resource IDs."
  value       = { for k, v in azurerm_service_plan.main : k => v.id }
}

output "service_plan_names" {
  description = "Map of App Service Plan names."
  value       = { for k, v in azurerm_service_plan.main : k => v.name }
}
