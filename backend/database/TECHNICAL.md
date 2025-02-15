# CosmosDB Technical Documentation

## Verified Configuration

- **Account Name**: talha-resume-db-2025-v3
- **API Type**: MongoDB API
- **Region**: UAE North
- **Capacity Mode**: Serverless
- **Consistency Level**: Session

## Database Details

```json
{
  "name": "visitordb",
  "collection": "visitors",
  "indexes": [
    {
      "key": {
        "keys": ["_id"]
      }
    }
  ],
  "shardKey": {
    "id": "Hash"
  }
}
```

## Verification Commands

```powershell
# Verify collection configuration
az cosmosdb mongodb collection list `
    --account-name talha-resume-db-2025-v3 `
    --resource-group rg-cloudresume `
    --database-name visitordb
```

## Cost Analysis

- Pay-per-request pricing
- No minimum RU/s commitment
- Estimated monthly cost: < $1 for expected traffic
