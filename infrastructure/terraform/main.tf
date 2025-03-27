terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "rg-cloudresume"
    storage_account_name = "talhaterrastate27998"
    container_name      = "tfstate"
    key                 = "cloudresume.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group - minimal declaration
resource "azurerm_resource_group" "main" {
  name     = "rg-cloudresume"
  location = "qatarcentral"
}

# Storage Account - minimal declaration
resource "azurerm_storage_account" "website" {
  name                     = "talhacrc0210"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# CDN Profile - minimal declaration
resource "azurerm_cdn_profile" "main" {
  name                = "cdn-talha-resume"
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
}

# CosmosDB Account - minimal declaration
resource "azurerm_cosmosdb_account" "main" {
  name                = "talha-resume-db-2025-v3"
  location            = "uaenorth"
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "MongoDB"
  
  consistency_policy {
    consistency_level = "Session"
  }
  
  geo_location {
    location          = "uaenorth"
    failover_priority = 0
  }
}

# Function App Service Plan - minimal declaration
resource "azurerm_service_plan" "main" {
  name                = "UAENorthLinuxDynamicPlan"
  resource_group_name = azurerm_resource_group.main.name
  location            = "uaenorth"
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Function App - minimal declaration
resource "azurerm_linux_function_app" "main" {
  name                = "talha-resume-func-2025"
  resource_group_name = azurerm_resource_group.main.name
  location            = "uaenorth"
  service_plan_id     = azurerm_service_plan.main.id
  
  site_config {}
}
