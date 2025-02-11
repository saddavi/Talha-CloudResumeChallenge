# Azure Configuration Guide

## Storage Account Details

- Name: talhacrc0210
- Location: Qatar Central
- Type: Static Website
- Tier: Standard_LRS
- Security: HTTPS-only, TLS 1.2

## Current Configuration

- Resource Group: rg-cloudresume (Qatar)
- Budget Controls: $20 monthly cap
  - Alert at 50% ($10)
  - Alert at 80% ($16)
  - Alert at 90% ($18)

## Static Website Configuration

- Status: Enabled
- Index Document: index.html
- Error Document: error.html
- Access: $web container only
- Security: Principle of least privilege

## CLI Commands

```powershell
# Get storage account details
az storage account show --name talhacrc0210 --resource-group rg-cloudresume

# Get static website URL
az storage account show --name talhacrc0210 --query "primaryEndpoints.web" --output tsv
```
