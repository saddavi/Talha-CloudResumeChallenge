# outputs.tf - A separate file for output definitions

output "website_url" {
  value = "https://${azurerm_storage_account.website.primary_web_host}"
}

output "cdn_endpoint_url" {
  value = "https://${azurerm_cdn_endpoint.main.fqdn}"
}

output "function_app_url" {
  value = "https://${azurerm_linux_function_app.main.default_hostname}/api/VisitorCounter"
}

output "cosmos_connection_string" {
  value     = azurerm_cosmosdb_account.main.primary_mongodb_connection_string
  sensitive = true
}

output "storage_account_name" {
  description = "The name of the static website storage account"
  value       = azurerm_storage_account.website.name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "subscription_id" {
  description = "The subscription ID"
  value       = "9af1a87d-1c54-4758-88fd-27d35a7a228c"  # From your resource IDs
}