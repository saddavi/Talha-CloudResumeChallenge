output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = module.storage.name
}

output "static_website_url" {
  value = module.storage.primary_web_endpoint
}

output "cdn_endpoint" {
  value = module.cdn.endpoint_hostname
}

output "function_app_name" {
  value = module.function.name
}

output "function_app_url" {
  value = module.function.default_hostname
}

output "cosmosdb_endpoint" {
  value = module.database.endpoint
}