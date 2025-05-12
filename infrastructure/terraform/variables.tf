variable "storage_connection_string" {
  description = "Connection string for Azure Storage"
  type        = string
  sensitive   = true
}

variable "cosmosdb_connection_string" {
  description = "Connection string for Cosmos DB"
  type        = string
  sensitive   = true
}
