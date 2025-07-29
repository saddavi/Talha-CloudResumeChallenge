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
    container_name       = "tfstate"
    key                  = "cloudresume.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-cloudresume"
  location = "qatarcentral"
}

# Storage Account
resource "azurerm_storage_account" "website" {
  name                              = "talhacrc0210"
  resource_group_name               = azurerm_resource_group.main.name
  location                          = azurerm_resource_group.main.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  allow_nested_items_to_be_public   = false
  cross_tenant_replication_enabled  = false

  tags = {}
}

# CDN Profile
resource "azurerm_cdn_profile" "main" {
  name                = "cdn-talha-resume"
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
}

# CDN Endpoint
resource "azurerm_cdn_endpoint" "main" {
  name                = "cdn-talha-endpoint"
  profile_name        = azurerm_cdn_profile.main.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  origin {
    name      = "primary"
    host_name = azurerm_storage_account.website.primary_web_host
  }

  origin_host_header             = azurerm_storage_account.website.primary_web_host
  is_compression_enabled         = true
  is_http_allowed               = true
  is_https_allowed              = true
  querystring_caching_behaviour = "IgnoreQueryString"

  content_types_to_compress = [
    "text/plain",
    "text/html",
    "text/css",
    "application/xml",
    "text/javascript",
    "application/javascript",
    "application/json"
  ]

  delivery_rule {
    name  = "redirect-to-https"
    order = 1

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}

# Custom Domain for www
resource "azurerm_cdn_endpoint_custom_domain" "www" {
  name            = "www-talharesume-com"
  cdn_endpoint_id = azurerm_cdn_endpoint.main.id
  host_name       = "www.talharesume.com"

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
  }
}

# Custom Domain for naked domain
resource "azurerm_cdn_endpoint_custom_domain" "naked" {
  name            = "talharesume-com"
  cdn_endpoint_id = azurerm_cdn_endpoint.main.id
  host_name       = "talharesume.com"

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
  }
}

# CosmosDB Account
resource "azurerm_cosmosdb_account" "main" {
  name                = "talha-resume-db-2025-v3"
  location            = "qatarcentral"
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

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Geo"
  }

  analytical_storage {
    schema_type = "FullFidelity"
  }

  geo_location {
    location          = "uaenorth"
    failover_priority = 0
  }

  network_acl_bypass_ids = []

  tags = {}
}

# Function App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "UAENorthLinuxDynamicPlan"
  resource_group_name = azurerm_resource_group.main.name
  location            = "uaenorth"
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Function App
resource "azurerm_linux_function_app" "main" {
  name                = "talha-resume-func-2025"
  resource_group_name = azurerm_resource_group.main.name
  location            = "uaenorth"
  service_plan_id     = azurerm_service_plan.main.id

  storage_account_name       = azurerm_storage_account.website.name
  storage_account_access_key = azurerm_storage_account.website.primary_access_key
  client_certificate_mode    = "Required"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME             = "python"
    FUNCTIONS_EXTENSION_VERSION          = "~4"
    AzureWebJobsStorage                  = var.storage_connection_string  # Use variable instead of hardcoded secret
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = var.storage_connection_string  # Use variable instead of hardcoded secret
    COSMOS_CONNECTION_STRING             = var.cosmosdb_connection_string  # Use variable instead of hardcoded secret
    WEBSITE_HTTPLOGGING_RETENTION_DAYS   = "3"
    APPINSIGHTS_INSTRUMENTATIONKEY       = "74e63443-a5f8-4159-80ae-758e38c0c7de"
    APPLICATIONINSIGHTS_CONNECTION_STRING = "InstrumentationKey=74e63443-a5f8-4159-80ae-758e38c0c7de;IngestionEndpoint=https://uaenorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://uaenorth.livediagnostics.monitor.azure.com/;ApplicationId=0db4e2df-f0d8-4302-984f-67ca4bfe8dd7"
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }

    ftps_state    = "FtpsOnly"
    http2_enabled = true

    application_insights_connection_string = "InstrumentationKey=74e63443-a5f8-4159-80ae-758e38c0c7de;IngestionEndpoint=https://uaenorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://uaenorth.livediagnostics.monitor.azure.com/"
    application_insights_key              = "74e63443-a5f8-4159-80ae-758e38c0c7de"

    app_service_logs {
      disk_quota_mb         = 100
      retention_period_days = 3
    }

    cors {
      allowed_origins     = ["*", "https://talharesume.com", "https://www.talharesume.com"]
      support_credentials = false
    }

    ip_restriction_default_action     = "Allow"
    scm_ip_restriction_default_action = "Allow"
  }

  sticky_settings {
    app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY"
    ]
  }

  tags = {
    "hidden-link: /app-insights-conn-string"         = "InstrumentationKey=74e63443-a5f8-4159-80ae-758e38c0c7de;IngestionEndpoint=https://uaenorth-0.in.applicationinsights.azure.com/;LiveEndpoint=https://uaenorth.livediagnostics.monitor.azure.com/;ApplicationId=0db4e2df-f0d8-4302-984f-67ca4bfe8dd7"
    "hidden-link: /app-insights-instrumentation-key" = "74e63443-a5f8-4159-80ae-758e38c0c7de"
    "hidden-link: /app-insights-resource-id"         = "/subscriptions/9af1a87d-1c54-4758-88fd-27d35a7a228c/resourceGroups/rg-cloudresume/providers/microsoft.insights/components/talha-resume-func-2025"
  }
}

# Outputs
output "cdn_endpoint_hostname" {
  value = azurerm_cdn_endpoint.main.fqdn
}

output "storage_primary_web_endpoint" {
  value = azurerm_storage_account.website.primary_web_endpoint
}

output "dns_configuration_instructions" {
  value = <<EOF
DNS Configuration Required in Namecheap:

1. Delete existing A record for @ (naked domain)
2. Add CNAME record for @ pointing to: ${azurerm_cdn_endpoint.main.fqdn}
3. Update CNAME record for www pointing to: ${azurerm_cdn_endpoint.main.fqdn}

After DNS changes, both http://talharesume.com and https://talharesume.com will work properly.
EOF
}