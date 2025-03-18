# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "rg-cloudresume"
    storage_account_name = "talhaterrastate27998"  # Using the existing storage account name
    container_name       = "tfstate"
    key                  = "cloudresume.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Variables
variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "talha"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-cloudresume"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "UAE North"  # Based on your README
}

variable "backup_location" {
  description = "Backup Azure region for resources"
  type        = string
  default     = "Qatar Central"  # Based on your README
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "CloudResumeChallenge"
    Owner       = "Talha"
  }
}

variable "allowed_origins" {
  description = "Allowed origins for CORS"
  type        = list(string)
  default     = ["https://www.talharesume.com"]
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account for Static Website Hosting
resource "azurerm_storage_account" "website" {
  name                     = "${var.prefix}crc0210"  # Based on your README
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"
  
  static_website {
    index_document         = "index.html"
    error_404_document     = "error.html"
  }
  
  tags = var.tags
}

# CDN Profile
resource "azurerm_cdn_profile" "main" {
  name                = "cdn-${var.prefix}-resume"  # Based on your README
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
  tags                = var.tags
}

# CDN Endpoint
resource "azurerm_cdn_endpoint" "main" {
  name                = "cdn-${var.prefix}-endpoint"  # Based on your README
  profile_name        = azurerm_cdn_profile.main.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  origin_host_header  = azurerm_storage_account.website.primary_web_host
  
  origin {
    name      = "websiteorigin"
    host_name = azurerm_storage_account.website.primary_web_host
  }
  
  # Optional: Add custom domain configuration here if you have one
  # custom_domain {
  #   name = "www.talharesume.com"
  #   host_name = "www.talharesume.com"
  # }
  
  tags = var.tags
}

# CosmosDB Account (MongoDB API)
resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.prefix}-resume-db-2025-v3"  # Based on your README
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "MongoDB"
  
  capabilities {
    name = "EnableMongo"
  }
  
  capabilities {
    name = "EnableServerless"
  }
  
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }
  
  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }
  
  tags = var.tags
}

# CosmosDB Database
resource "azurerm_cosmosdb_mongo_database" "main" {
  name                = "visitordb"  # Based on your code files
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
}

# CosmosDB Collection
resource "azurerm_cosmosdb_mongo_collection" "main" {
  name                = "visitors"  # Based on your code files
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  database_name       = azurerm_cosmosdb_mongo_database.main.name
  
  index {
    keys   = ["_id"]
    unique = true
  }
}

# Storage account for Function App
resource "azurerm_storage_account" "function" {
  name                     = "${var.prefix}resumefunc2025"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

# App Service Plan for Function App
resource "azurerm_service_plan" "main" {
  name                = "plan-${var.prefix}-resume-func"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "Y1"  # Consumption plan
  tags                = var.tags
}

# Function App
resource "azurerm_linux_function_app" "main" {
  name                       = "${var.prefix}-resume-func-2025"  # Based on your README
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  service_plan_id            = azurerm_service_plan.main.id
  storage_account_name       = azurerm_storage_account.function.name
  storage_account_access_key = azurerm_storage_account.function.primary_access_key
  
  site_config {
    application_stack {
      python_version = "3.11"  # Based on your code requirements
    }
    
    cors {
      allowed_origins = concat(
        ["https://${azurerm_storage_account.website.primary_web_host}", 
         "https://${azurerm_cdn_endpoint.main.host_name}"], 
        var.allowed_origins
      )
      support_credentials = false
    }
  }
  
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"    = "python"
    "COSMOS_CONNECTION_STRING"    = azurerm_cosmosdb_account.main.connection_strings[0]
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "ENABLE_ORYX_BUILD"           = "true"
  }
  
  tags = var.tags
}

# Outputs
output "website_url" {
  value = "https://${azurerm_storage_account.website.primary_web_host}"
}

output "cdn_endpoint_url" {
  value = "https://${azurerm_cdn_endpoint.main.host_name}"
}

output "function_app_url" {
  value = "https://${azurerm_linux_function_app.main.default_hostname}/api/VisitorCounter"
}

output "cosmos_connection_string" {
  value     = azurerm_cosmosdb_account.main.connection_strings[0]
  sensitive = true
}