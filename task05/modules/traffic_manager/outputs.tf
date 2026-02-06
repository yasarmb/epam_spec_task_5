output "traffic_manager_fqdn" {
  description = "The FQDN of the Azure Traffic Manager profile."
  value       = azurerm_traffic_manager_profile.main.fqdn
}

output "profile_id" {
  description = "The resource ID of the Traffic Manager profile."
  value       = azurerm_traffic_manager_profile.main.id
}
