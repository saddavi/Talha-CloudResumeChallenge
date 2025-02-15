# Infrastructure Documentation

## Resource Overview
- **Resource Group**: rg-cloudresume
- **Region**: UAE North
- **Created**: February 15, 2024

## Components
1. **Storage Account** (talhacrc0210)
   - Type: General Purpose v2
   - Replication: LRS
   - Access tier: Hot

2. **CDN Profile** (cdn-talha-resume)
   - Endpoint: cdn-talha-endpoint
   - Performance improvement: 33%

3. **CosmosDB** (talha-resume-db-2025-v3)
   - API: MongoDB
   - Mode: Serverless
   - Region: UAE North

## Cost Management
- Monthly budget: $20
- Current estimates:
  - Storage: ~$0.10/month
  - CDN: ~$0.15/month
  - CosmosDB: < $1/month

## Security Configuration
- SSL/TLS enabled
- HTTPS enforced
- Network security rules
- CORS configuration (pending)