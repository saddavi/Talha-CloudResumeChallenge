# Visitor Counter API

## Endpoint

`GET /api/VisitorCounter`

## Description

Increments and returns the visitor count for the resume website.

## Response

- **Format**: Text
- **Example**: `Visitor count: 42`

## Error Handling

- Returns 500 status code on database errors
- Returns error message in response body

## Local Development

1. Install dependencies:

   ```powershell
   pip install -r requirements.txt
   ```

2. Configure local settings:
   Create `local.settings.json` in the api directory:

   ```json
   {
     "IsEncrypted": false,
     "Values": {
       "FUNCTIONS_WORKER_RUNTIME": "python",
       "AzureWebJobsStorage": "UseDevelopment=true",
       "COSMOS_CONNECTION_STRING": "your_cosmos_db_connection_string"
     }
   }
   ```

3. Start function:

   ```powershell
   # Activate Python virtual environment
   .\.venv\Scripts\Activate.ps1

   # Start Azure Functions host
   func start
   ```

4. Test the API:
   - Local endpoint: http://localhost:7071/api/VisitorCounter
   - Production endpoint: https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter

## Configuration Details

### Environment Variables

- `COSMOS_CONNECTION_STRING`: MongoDB connection string for Azure Cosmos DB
- `FUNCTIONS_WORKER_RUNTIME`: Set to "python"
- `AzureWebJobsStorage`: Storage account connection string

### Database Schema

```json
{
  "id": "visitor_count",
  "count": number
}
```

### CORS Configuration

The API supports Cross-Origin Resource Sharing (CORS) with:

- Allowed Methods: GET
- Allowed Headers: Content-Type
- Allowed Origins: \* (all origins in development)
