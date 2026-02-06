output "resource_groups" {
  description = "Map of resource group attributes (name, location, tags) keyed by logical key."
  value = {
    for k, v in azurerm_resource_group.main : k => {
      name     = v.name
      location = v.location
      tags     = v.tags
    }
  }
}

output "resource_group_ids" {
  description = "Map of resource group resource IDs."
  value       = { for k, v in azurerm_resource_group.main : k => v.id }
}
