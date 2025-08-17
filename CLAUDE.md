# CLAUDE.md - Domain Redirect Fix Project

## PowerShell Pipeline Method (PPM)
**Problem**: talharesume.com redirect broken - multiple access patterns not working  
**Goal**: Fix all domain variations → redirect to main site  
**Method**: Direct execution, no overthinking

## Domain Access Requirements
All these MUST work:
- talharesume.com
- www.talharesume.com  
- http://talharesume.com
- https://talharesume.com
- HTTP://talharesume.com (any case variation)

## Current Stack
- **Domain**: Namecheap.com
- **Hosting**: Azure Cloud
- **CDN**: Cloudflare (recently modified - source of issues)

## PPM Commands

### 1. Diagnose Current State
```bash
nslookup talharesume.com
nslookup www.talharesume.com
curl -I http://talharesume.com
curl -I https://talharesume.com
curl -I https://www.talharesume.com
```

### 2. Fix DNS/CDN Configuration
```bash
# Azure CDN endpoint configuration
az cdn endpoint show --name [endpoint] --profile-name [profile] --resource-group [rg]
az cdn custom-domain create --endpoint-name [endpoint] --name www --hostname www.talharesume.com
```

### 3. Verify Fix
```bash
# Test all variations return 200 or proper redirect
for url in "http://talharesume.com" "https://talharesume.com" "https://www.talharesume.com"; do
  curl -I "$url"
done
```

## Project Structure
```
Talha-CloudResumeChallenge/
├── frontend/           # Static website files
├── api/               # Azure Functions
├── infrastructure/    # IaC templates
└── CLAUDE.md         # This file
```

## Error Conditions
- 404 errors on domain variations
- Cloudflare SSL/redirect loops
- Azure CDN misconfiguration
- DNS A record issues

## Success Criteria
✓ All domain variations resolve correctly  
✓ HTTPS enforced automatically  
✓ www redirects to non-www (or vice versa)  
✓ No SSL certificate errors

## PPM Rules
- Fix first, optimize later
- Test immediately after each change
- One problem = One solution = One commit
- No documentation until it works

## Cloudflare Reset Protocol
If Cloudflare broke everything:
1. Pause Cloudflare
2. Test direct Azure access
3. Re-enable with minimal config
4. Add redirects incrementally

## Azure CDN Commands
```bash
# List endpoints
az cdn endpoint list --profile-name [profile] --resource-group [rg]

# Show custom domains
az cdn custom-domain show --endpoint-name [endpoint] --name [domain] --profile-name [profile] --resource-group [rg]
```

## Success Output Only
- "✓ Domain redirect fixed"
- "✓ All variations working" 
- "✗ Error: [specific issue]"

No explanations during execution - just results.