# Cloud Resume Challenge

![Deployment Status](https://github.com/saddavi/Talha-CloudResumeChallenge/actions/workflows/deploy.yml/badge.svg)

> A modern, serverless resume platform showcasing cloud architecture and DevOps practices

![Project Status](https://img.shields.io/badge/status-in%20progress-brightgreen)
![Azure](https://img.shields.io/badge/cloud-Azure-blue)
![Infrastructure as Code](https://img.shields.io/badge/DevOps-Infrastructure%20as%20Code-orange)
![Deployment](https://img.shields.io/badge/deployment-automated-success)
![Last Updated](https://img.shields.io/badge/last%20updated-2025--02--13-brightgreen)
![Author](https://img.shields.io/badge/author-saddavi-purple)

### Live Demo

🔗 [www.talharesume.com](https://www.talharesume.com)

## Overview

This project demonstrates end-to-end cloud architecture implementation, combining Azure services, infrastructure as code, and modern DevOps practices. It delivers a high-performance, secure, and scalable resume website while showcasing real-world cloud engineering skills.

## Implementation Timeline

- [2024-02-14] Frontend deployment completed
- [2024-02-15] CosmosDB implementation started
- [2024-02-19] Database connection implemented and tested ✅
  - Connection testing framework created
  - Error handling and retry logic implemented
  - Security measures for connection strings

## Implementation Status

### High-Level Progress

- ✅ Frontend Infrastructure
- ✅ CDN Implementation
- ✅ Custom Domain Setup
- 🔄 Backend Services
- 🔄 CI/CD Pipeline

### Detailed Implementation Status

#### Completed Components ✅

- **Azure Static Website Hosting**
  - Storage account created and configured (talhacrc0210)
  - Static website enabled with proper endpoints
  - Files uploaded to $web container
  - Endpoint verification complete
- **CDN Implementation**
  - CDN Profile: cdn-talha-resume
  - CDN Endpoint: cdn-talha-endpoint
  - Performance testing complete (33% improvement)
- **Custom Domain Setup**
  - Domain: www.talharesume.com
  - SSL/TLS configuration complete
  - DNS configuration verified
  - HTTPS enforced
- **Database Setup** (Completed: 2024-02-19)
  - CosmosDB instance created (talha-resume-db-2025-v3)
  - MongoDB API enabled
  - Location: UAE North
  - Serverless capacity mode
  - Session consistency configured
  - Database: visitordb
  - Collection: visitors
    - Indexed on: \_id
    - Shard key: id (Hash)
    - Type: MongoDB collection

#### In Progress 🔄

- **Backend Development**
  - Visitor counter implementation
  - Azure Functions API
- **CI/CD Pipeline**
  - GitHub Actions workflow
  - Automated testing
  - Deployment automation

## System Architecture

### High-Level Overview

```mermaid
graph TD
    A[Static Website] -->|CDN| B[Users]
    C[Backend APIs] -->|Data| D[Database]
    E[CI/CD] -->|Deploy| A
```

### Detailed Architecture Diagram

```mermaid
flowchart TD
    classDef securityLayer fill:#f9f,stroke:#333,stroke-width:2px
    classDef storageLayer fill:#bbdefb,stroke:#333,stroke-width:2px
    classDef apiLayer fill:#c8e6c9,stroke:#333,stroke-width:2px
    classDef monitoringLayer fill:#ffe0b2,stroke:#333,stroke-width:2px

    subgraph Security["Security Layer"]
        SSL["SSL/TLS Certificate"]
        FW["Azure Firewall"]
    end

    subgraph Frontend["Frontend Layer"]
        UI["Static Website\n(HTML/CSS/JS)"]
        VC["Visitor Counter\nJavaScript"]
    end

    subgraph Delivery["Content Delivery"]
        CDN["Azure CDN"]
        DNS["Custom Domain\ntalharesume.com"]
    end

    subgraph Storage["Storage Layer"]
        AS["Azure Storage\n($web container)"]
    end

    subgraph Backend["Backend Services"]
        AF["Azure Functions\nAPI"]
        DB["CosmosDB"]
    end

    subgraph Pipeline["CI/CD Pipeline"]
        GH["GitHub Repository"]
        GA["GitHub Actions"]
    end

    subgraph Monitoring["Monitoring & Analytics"]
        AM["Azure Monitor"]
        AL["Alert Rules"]
        MT["Metrics"]
    end

    UI -->|Stored in| AS
    AS -->|Optimized by| CDN
    CDN -->|Served via| DNS
    VC -->|Calls| AF
    DNS -->|Secured by| SSL
    CDN -->|Protected by| FW
    AF -->|CRUD Operations| DB
    AF -->|Logs| AM
    GH -->|Triggers| GA
    GA -->|Deploys to| AS
    GA -->|Updates| AF
    AM -->|Triggers| AL
    AM -->|Collects| MT

    class Security securityLayer
    class Storage storageLayer
    class Backend apiLayer
    class Monitoring monitoringLayer
```

## Performance & Controls

### Key Metrics

- Page Load Time: 101ms (CDN-optimized)
- Cache Hit Ratio: >95%
- Global Availability: 99.99%

### Detailed Performance Analysis

#### CDN Performance Analysis

```mermaid
graph LR
    A[Original: 152ms] -->|33% Faster| B[CDN: 101ms]
    style A fill:#ff9999
    style B fill:#99ff99
```

#### Detailed Metrics

| Metric        | Original | With CDN | Status            |
| ------------- | -------- | -------- | ----------------- |
| Response Time | 152ms    | 101ms    | ✅ 33% Faster     |
| Cache Status  | N/A      | TCP_HIT  | ✅ Caching Active |
| Layer 1 Cache | N/A      | L1_T2    | ✅ Optimized      |
| SSL/TLS       | Enabled  | Enabled  | ✅ Secure         |

#### Resource Management

- Region: Qatar Central
- Monthly Budget: $20
- Alert Thresholds:
  - 50% ($10)
  - 80% ($16)
  - 90% ($18)

## Development Setup

### Quick Start

```bash
git clone https://github.com/saddavi/Talha-CloudResumeChallenge.git
cd Talha-CloudResumeChallenge
npm install
```

### Detailed Development Setup

#### Prerequisites

```bash
# Required Tools
- Azure CLI
- Node.js
- Git
- Visual Studio Code (recommended)

# Azure CLI Installation
## Windows:
winget install -e --id Microsoft.AzureCLI
# OR
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi

## macOS:
brew update && brew install azure-cli

## Linux:
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

#### VS Code Extensions

- Azure Account
- Azure Static Web Apps
- Azure Resources
- Azure Storage

#### Azure Cloud Shell Setup

- Pre-authenticated environment
- 5 GB persistent storage
- Built-in code editor
- Supports both Bash and PowerShell

#### Project Structure

```plaintext
cloud-resume/
├── frontend/
│   ├── index.html          # Resume content
│   ├── css/
│   │   └── styles.css      # Styling
│   └── js/
│       └── counter.js      # Visitor counter
├── backend/
│   ├── api/               # Azure Functions
│   └── database/          # CosmosDB setup
├── infrastructure/
│   └── terraform/         # IaC templates
└── .github/
    └── workflows/         # CI/CD pipelines
```

## Security Implementation

### Key Features

- SSL/TLS encryption
- Secured storage access
- Automated security updates

### Detailed Security Configuration

#### Security Measures

- Principle of least privilege implementation
- Isolated web container configuration
- Azure Firewall rules
- Rate limiting
- DDoS protection
- Regular security audits

#### SSL/TLS Configuration

- Protocol: TLS 1.2+
- Cipher suites: Modern only
- HSTS enabled
- Certificate auto-renewal

## Database Documentation Update

### Changes Made

- Updated CosmosDB configuration details
- Documented MongoDB API implementation
- Added serverless capacity mode specifics
- Updated region information to UAE North

### Verified Components

- [x] CosmosDB account creation
- [x] MongoDB API configuration
- [x] Database creation
- [x] Collection setup
- [x] Serverless mode enablement

### Related Issues

Closes #[Issue number] - Database setup documentation

### Screenshots

![CosmosDB Configuration](link-to-screenshot) <!-- Optional -->

## Future Enhancements

### Performance Optimization

- Implement Azure Front Door
- Enable HTTP/3
- Optimize asset delivery

### Detailed Enhancement Plans

#### Planned Improvements

1. **Performance Optimization**

   - Azure Front Door implementation
   - HTTP/3 enablement
   - Asset delivery optimization
   - Browser caching strategies
   - CDN rule refinement

2. **Security Enhancements**

   - WAF protection
   - Enhanced rate limiting
   - Security monitoring improvements
   - Automated security testing
   - Compliance monitoring

3. **Feature Additions**
   - Blog integration
   - Portfolio showcase
   - Interactive elements
   - Analytics dashboard
   - Performance monitoring tools

## Additional Resources

- [Azure Static Website Documentation](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)
- [Cloud Resume Challenge Guide](https://cloudresumechallenge.dev/)
- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)

---

_Last updated: 2025-02-13 16:57:00 UTC by @saddavi_

_This project is part of the Cloud Resume Challenge, demonstrating practical cloud engineering skills and best practices._

```

```
