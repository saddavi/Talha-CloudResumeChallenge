
---
# Talha's Cloud Resume Challenge
[![Deployment Status](https://img.shields.io/badge/Deployment-Success-brightgreen)](#)
[![Azure](https://img.shields.io/badge/Platform-Azure-blue)](#)
[![Infrastructure as Code](https://img.shields.io/badge/IaC-Terraform-purple)](#)
[![Last Updated](https://img.shields.io/badge/Last%20Updated-2025--02--13-orange)](#)
## 🌐 Live Demo
Check out the live demo [here](http://www.talharesume.com).
## 📜 Overview
This project showcases a modern, serverless resume platform built using Azure services, infrastructure as code (IaC), and DevOps best practices. It demonstrates real-world cloud engineering skills by delivering a high-performance, secure, and scalable resume website.
## 📅 Implementation Timeline
- **2024-02-14**: Frontend deployment completed.
- **2024-02-15**: Started CosmosDB implementation.
- **2024-02-19**: Database connection implemented and tested.
- **2024-02-22**: Visitor counter implementation completed with local testing.
## 🏗️ Implementation Status
### Completed Components ✅
- **Frontend Infrastructure**: Azure Static Website Hosting with CDN and custom domain setup.
- **Database Setup**: CosmosDB instance with MongoDB API, serverless capacity mode, and security measures.
- **Visitor Counter**: Azure Function created with Python, integrated with CosmosDB, and locally tested.
### In Progress 🔄
- **Backend Development**: Enhancing visitor counter and Azure Functions API.
- **CI/CD Pipeline**: Developing GitHub Actions workflows for automated testing and deployment.
## 🗺️ System Architecture
### High-Level Overview
```mermaid
graph TD
    A[Static Website] -->|CDN| B[Users]
    C[Backend APIs] -->|Data| D[Database]
    E[CI/CD] -->|Deploy| A
```
### Detailed Architecture
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
        UI["Static Website (HTML/CSS/JS)"]
        VC["Visitor Counter JavaScript"]
    end
    subgraph Delivery["Content Delivery"]
        CDN["Azure CDN"]
        DNS["Custom Domain talharesume.com"]
    end
    subgraph Storage["Storage Layer"]
        AS["Azure Storage ($web container)"]
    end
    subgraph Backend["Backend Services"]
        AF["Azure Functions API"]
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
## 📊 Performance & Controls
### Key Metrics
- **Page Load Time**: 101ms (CDN-optimized)
- **Cache Hit Ratio**: >95%
- **Global Availability**: 99.99%
### CDN Performance Analysis
```mermaid
graph LR
    A[Original: 152ms] -->|33% Faster| B[CDN: 101ms]
    style A fill:#ff9999
    style B fill:#99ff99
```
## 🛠️ Development Setup
### Quick Start
```bash
git clone https://github.com/saddavi/Talha-CloudResumeChallenge.git
cd Talha-CloudResumeChallenge
npm install
```
### Prerequisites
- **Azure CLI**
- **Node.js**
- **Git**
- **Visual Studio Code** (recommended)
### Project Structure
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
## 🔒 Security Implementation
- **SSL/TLS Encryption**
- **Secured Storage Access**
- **Automated Security Updates**
- **Regular Security Audits**
## 📈 Future Enhancements
- **Performance Optimization**: Implement Azure Front Door, enable HTTP/3, and optimize asset delivery.
- **Security Enhancements**: Enhanced rate limiting, WAF protection, and automated security testing.
- **Feature Additions**: Blog integration, portfolio showcase, and interactive elements.
## 📚 Additional Resources
- [Azure Static Website Documentation](https://docs.microsoft.com/azure/storage/blobs/storage-blob-static-website)
- [Cloud Resume Challenge Guide](https://cloudresumechallenge.dev/)
- [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/)
