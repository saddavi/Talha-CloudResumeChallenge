# Terraform for Cloud Resume Challenge

This directory contains Terraform configuration files to provision the infrastructure for the Cloud Resume Challenge project.

## Resources Created

- Resource Group
- Storage Account for Static Website Hosting
- CDN Profile and Endpoint
- CosmosDB Account (MongoDB API)
- CosmosDB Database and Collection
- Storage Account for Function App
- App Service Plan
- Function App

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- Azure CLI installed and authenticated
- Az module for PowerShell (optional)

## Setup Authentication

Before running Terraform, you need to authenticate with Azure:

```powershell
# Login to Azure
az login

# Set the subscription (if you have multiple)
az account set --subscription="SUBSCRIPTION_ID"
```

## Initialize Terraform

```powershell
# Initialize Terraform
terraform init
```

## Plan and Apply

```powershell
# See what Terraform will do
terraform plan -out=tfplan

# Apply the changes
terraform apply tfplan
```

## Accessing Outputs

After applying, Terraform will output important URLs and information:

- `website_url`: URL for your static website
- `cdn_endpoint_url`: URL for your CDN endpoint
- `function_app_url`: URL for your visitor counter API
- `resource_group_name`: Name of the created resource group
- `storage_account_name`: Name of the storage account for the website

## Cleanup

If you need to remove all created resources:

```powershell
terraform destroy
```

## Notes

- The CosmosDB connection string is marked as sensitive and won't be displayed in the terminal output
- You'll need to manually upload your website files to the storage account
- You may need to update the CORS settings based on your specific domain
- Custom domain and SSL certificate configuration needs additional manual steps
