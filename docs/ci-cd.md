# CI/CD Implementation for Cloud Resume Challenge

This document outlines the CI/CD pipeline implementation for the Cloud Resume Challenge project.

## GitHub Actions Workflows

### Frontend Validation Workflow

**File**: `.github/workflows/frontend-validation.yml`

This workflow validates the HTML code in the frontend directory to ensure it meets best practices and standards.

**Trigger**: 
- Push to main branch that affects files in the `frontend/` directory
- Manual trigger from GitHub Actions tab

**Steps**:
1. Check out the repository
2. Set up Node.js environment (v20)
3. Install HTML validation tools
4. Run HTML validation against all HTML files
5. Report any issues found

**Implementation Notes**:
- Uses HTML-validate package for standards compliance
- Configuration in `.htmlvalidate.json` defines validation rules
- Currently checks for:
  - Properly encoded special characters (`&amp;`, `&lt;`, etc.)
  - No trailing whitespace
  - Required attributes on elements
  - Proper void element style

### Backend Deployment (In Progress)

**File**: `.github/workflows/backend-deploy.yml`

This workflow will deploy the Azure Function API.

**Planned Steps**:
1. Check out the repository
2. Setup Python environment
3. Install Azure Functions Core Tools
4. Run tests
5. Deploy to Azure Functions

## Validation Fixes

The HTML validation process identified several issues that were fixed:
- Encoded all ampersands (`&` → `&amp;`)
- Encoded less-than symbols (`<` → `&lt;`)
- Added required `type` attribute to button elements
- Removed trailing whitespace

## Next Steps

1. Complete the backend deployment workflow
2. Create a frontend deployment workflow
3. Implement CDN purge after deployments
4. Setup monitoring and notifications for CI/CD failures