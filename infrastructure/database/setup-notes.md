# CosmosDB Setup Notes

## Initial Setup Attempt - Qatar Central
- Resource Group: rg-cloudresume
- Initial target region: Qatar Central
- Status: ❌ Failed due to capacity constraints
- Error: Service unavailable in Qatar Central region

## Next Steps
1. Alternative Region Strategy:
   - Primary: West Europe
   - Future: Add Qatar Central as secondary region when capacity is available

## Provider Registration
```bash
az provider show --namespace Microsoft.DocumentDB --query "{Provider:namespace, Status:registrationState}" --output table
# Status: Registered ✅
