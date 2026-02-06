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
    - tags: Tags to apply
  EOT
}
