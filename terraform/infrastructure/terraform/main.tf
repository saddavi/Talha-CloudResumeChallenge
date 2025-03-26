# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.base_name}-rg"
  location = var.location
  tags     = var.tags
}

# Storage Module for static website
module "storage" {
  source               = "./modules/storage"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  storage_account_name = var.storage_account_name
  tags                 = var.tags
}

# CDN Module for content delivery
module "cdn" {
  source              = "./modules/cdn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  cdn_profile_name    = var.cdn_profile_name
  endpoint_origin     = module.storage.primary_web_endpoint
  domain_name         = var.domain_name
  tags                = var.tags
}

# Database Module for CosmosDB
module "database" {
  source               = "./modules/database"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  cosmosdb_account_name = var.cosmosdb_account_name
  tags                 = var.tags
}

# Application Insights for monitoring
module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  app_name            = var.base_name
  tags                = var.tags
}

# Function Module for backend API
module "function" {
  source                = "./modules/function"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  function_app_name     = var.function_app_name
  app_insights_key      = module.monitoring.instrumentation_key
  storage_account_name  = "${var.base_name}func"
  cosmosdb_connection   = module.database.connection_string
  tags                  = var.tags
}