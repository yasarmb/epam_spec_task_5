output "web_app_ids" {
  description = "Map of Windows Web App resource IDs."
  value       = { for k, v in azurerm_windows_web_app.main : k => v.id }
}

output "web_app_default_hostnames" {
  description = "Map of Windows Web App default hostnames (for Traffic Manager endpoints)."
  value       = { for k, v in azurerm_windows_web_app.main : k => v.default_hostname }
}

output "web_app_names" {
  description = "Map of Windows Web App names."
  value       = { for k, v in azurerm_windows_web_app.main : k => v.name }
}
