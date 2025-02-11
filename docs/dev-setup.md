# Development Environment Setup

## Prerequisites
- VS Code
- Azure CLI
- Git
- Azure Account

## VS Code Extensions
- Azure Account
- Azure Static Web Apps
- Azure Resources
- Azure Storage
- GitHub Copilot (optional)

## Initial Setup
```powershell
# Verify installations
az --version
git --version
code --version

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Login to Azure
az login
```

## Repository Setup
```powershell
# Clone repository
git clone https://github.com/saddavi/Talha-CloudResumeChallenge.git
cd cloud-resume

# Verify remote
git remote -v
```

## Best Practices
- Use consistent line endings (LF)
- Create feature branches for new work
- Pull before pushing changes
- Keep VS Code and extensions updated