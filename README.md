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
