# Talha-CloudResumeChallenge

## Current Progress

### Completed ✅

- HTML Resume Structure
  - Basic layout implemented
  - Semantic HTML used
- CSS Implementation
  - Styles separated into external file
  - Responsive design included

### In Progress 🔄

- Azure Static Website Hosting
  - ✅ Installing and configuring Azure CLI
  - ✅ Azure CLI authentication completed
  - ✅ Resource Group created in Qatar (qatarcentral)
  - 🔄 Troubleshooting subscription access
  - ⏳ Setting up Azure Storage Account

### Next Steps ⏳

- HTTPS/Azure CDN Configuration
- Custom Domain Setup
- JavaScript Visitor Counter
- Database Implementation (CosmosDB)
- Azure Functions API
- Python Backend Development
- Testing Implementation
- Infrastructure as Code (IaC)
- CI/CD Pipeline Setup

## Project Structure

```plaintext
cloud-resume/
├── index.html          # Main resume content
├── css/
│   └── styles.css     # Separated CSS styles
└── README.md          # Project documentation
```

## Local Development

```bash
# Start local development server
cd cloud-resume
code .                 # Open in VS Code
```

## Development Environment Setup

### Prerequisites

- VS Code
- Azure CLI
- Azure Account

### Terminal Configuration

#### macOS Setup

```bash
# Install Homebrew (Package Manager)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Azure CLI
brew update && brew install azure-cli
```

#### Windows Setup

```powershell
# Install Azure CLI via PowerShell
winget install -e --id Microsoft.AzureCLI
# OR
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
```

### VS Code Extensions (Both Platforms)

- Azure Account
- Azure Static Web Apps
- Azure Resources
- Azure Storage

### Azure Setup Verification

```bash
# Verify Azure CLI installation
az --version

# Login to Azure
az login
```

## Azure Storage Configuration

### Storage Account Details

```bash
# Naming Convention
- Format: [name][project][date]
- Example: talhacrc0210

# Configuration
- Type: Static Website
- Tier: Standard_LRS
- Security: HTTPS-only, TLS 1.2
- Location: Qatar Central

# Website Settings
- Index document: index.html
- Error document: error.html
```

## Azure Cloud Shell

### Setup and Usage

```bash
# Access Methods
1. Visit portal.azure.com
2. Click the Cloud Shell icon (>_) in the top navigation bar
3. Choose "Bash" or "PowerShell" environment

# Features
- Pre-authenticated
- Pre-installed Azure CLI
- 5 GB persistent storage
- Built-in code editor
- Supports both Bash and PowerShell
```

### First-Time Setup

1. Select subscription for storage account
2. Create storage for Cloud Shell
3. Mount storage share

### Advantages

- No local installation needed
- Always up-to-date tools
- Works from any browser
- Built-in VS Code editor

## Cross-Platform Development Guide

### Best Practices

#### Version Control

- Use consistent line endings (LF)
- Commit from one platform at a time
- Keep `.gitignore` updated for both platforms

#### File Paths

- Use forward slashes (/) in paths
- Use relative paths when possible
- Avoid platform-specific absolute paths

#### Terminal Commands

macOS:

```bash
# Check Azure CLI version
az --version

# List storage accounts
az storage account list
```

Windows:

```powershell
# Check Azure CLI version
az --version

# List storage accounts
az storage account list
```

Note: Azure CLI commands remain the same across platforms!

## Resources

- [Azure Static Website Docs](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)
- [Azure Cloud Resume Challenge Guide](https://github.com/madebygps/cgc-azure-resume)
