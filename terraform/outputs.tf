# outputs.tf - A separate file for output definitions

output "website_url" {
  description = "The URL of the static website"
  value       = "https://${azurerm_storage_account.website.primary_web_host}"
}

output "cdn_endpoint_url" {
  description = "The URL of the CDN endpoint"
  value       = "https://${azurerm_cdn_endpoint.main.host_name}"
}

output "function_app_url" {
  description = "The URL of the visitor counter API"
  value       = "https://${azurerm_linux_function_app.main.default_hostname}/api/VisitorCounter"
}

output "cosmos_connection_string" {
  description = "The primary connection string for the CosmosDB account"
  value       = azurerm_cosmosdb_account.main.connection_strings[0]
  sensitive   = true  # This will hide the value in the console output for security
}

output "storage_account_name" {
  description = "The name of the static website storage account"
  value       = azurerm_storage_account.website.name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}
