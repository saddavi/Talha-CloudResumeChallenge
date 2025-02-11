# Cross-Platform Development Guide## Windows Setup`powershell# Install Azure CLIwinget install -e --id Microsoft.AzureCLI# ORInvoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi# Verify installationaz --version`## macOS Setup```bash

# Install Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Azure CLI

brew update && brew install azure-cli

# Verify installation

az --version

````

## Platform-Independent Commands
```bash
# Azure CLI commands work the same on all platforms
az login
az account show
az group list
````

## Best Practices

- Use forward slashes (/) in paths
- Use relative paths when possible
- Avoid platform-specific absolute paths
- Test commands on both platforms
