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

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-cloudresume"
  location = "qatarcentral"  # Updated to match existing location
  tags     = {}  # No tags defined in output
}

# Storage Account for Static Website Hosting
resource "azurerm_storage_account" "website" {
  name                     = "talhacrc0210"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Cool"  # Updated to match existing configuration
  https_traffic_only_enabled = true
  min_tls_version          = "TLS1_2"
  
  # Allow blob public access must match existing configuration
  allow_blob_public_access = false
  
  static_website {
    index_document         = "index.html"
    error_404_document     = "error.html"
  }
  
  tags = {}  # No tags defined in output
}

# CDN Profile
resource "azurerm_cdn_profile" "main" {
  name                = "cdn-talha-resume"
  location            = "Global"  # CDN profiles are global resources
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
  tags                = {}  # No tags defined in output
}

# CDN Endpoint
resource "azurerm_cdn_endpoint" "main" {
  name                = "cdn-talha-endpoint"
  profile_name        = azurerm_cdn_profile.main.name
  location            = azurerm_cdn_profile.main.location
  resource_group_name = azurerm_resource_group.main.name
  origin_host_header  = azurerm_storage_account.website.primary_web_host
  
  origin {
    name      = "websiteorigin"
    host_name = azurerm_storage_account.website.primary_web_host
  }
  
  tags = {}  # No tags defined in output
}

# CosmosDB Account (MongoDB API)
resource "azurerm_cosmosdb_account" "main" {
  name                = "talha-resume-db-2025-v3"
  location            = "Qatar Central"  # Matches existing region
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
    location          = "UAE North"  # Based on output showing UAE North as the location
    failover_priority = 0
  }
  
  backup_policy {
    type = "Periodic"
    
    periodic_mode_properties {
      backup_interval_in_minutes      = 240
      backup_retention_interval_in_hours = 8
      backup_storage_redundancy       = "Geo"
    }
  }
  
  tags = {}
}

# CosmosDB Database
resource "azurerm_cosmosdb_mongo_database" "main" {
  name                = "visitordb"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
}

# CosmosDB Collection
resource "azurerm_cosmosdb_mongo_collection" "main" {
  name                = "visitors"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  database_name       = azurerm_cosmosdb_mongo_database.main.name
  
  index {
    keys   = ["_id"]
    unique = true
  }
}

# For the Function App, we need to reference the existing service plan
resource "azurerm_service_plan" "main" {
  name                = "UAENorthLinuxDynamicPlan"  # Name from your Function App output
  resource_group_name = azurerm_resource_group.main.name
  location            = "UAE North"  # Function App is in UAE North
  os_type             = "Linux"
  sku_name            = "Y1"  # Dynamic plan for consumption
}

# Function App
resource "azurerm_linux_function_app" "main" {
  name                       = "talha-resume-func-2025"
  location                   = "UAE North"  # Function App is in UAE North
  resource_group_name        = azurerm_resource_group.main.name
  service_plan_id            = azurerm_service_plan.main.id
  
  site_config {
    application_stack {
      python_version = "3.11"
    }
    
    cors {
      allowed_origins = ["*", "https://talharesume.com", "https://www.talharesume.com"]
      support_credentials = false
    }
  }
  
  # Adding tags from the output
  tags = {
    "hidden-link: /app-insights-conn-string" = "InstrumentationKey=74e63443-a5f8-4159-80ae-758e38c0c7de;IngestionEndpoint=https://uaenorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://uaenorth.livediagnostics.monitor.azure.com/;ApplicationId=0db4e2df-f0d8-4302-984f-67ca4bfe8dd7"
    "hidden-link: /app-insights-instrumentation-key" = "74e63443-a5f8-4159-80ae-758e38c0c7de"
    "hidden-link: /app-insights-resource-id" = "/subscriptions/9af1a87d-1c54-4758-88fd-27d35a7a228c/resourceGroups/rg-cloudresume/providers/microsoft.insights/components/talha-resume-func-2025"
  }
  
  # Note: We can't see the app settings in the output, so we'll need to add them later
  # or retrieve them separately
}