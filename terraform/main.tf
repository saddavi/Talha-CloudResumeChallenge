# Main Terraform configuration file
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  
  # Remote state storage section (commented out)
}

provider "azurerm" {
  features {}
}

# Your resources will be defined here
