variable "base_name" {
  description = "Base name for resources"
  default     = "talha-resume"
}

variable "location" {
  description = "Azure region to deploy resources"
  default     = "UAE North"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    project     = "Cloud Resume Challenge"
    environment = "Production"
    managed_by  = "Terraform"
  }
}

variable "cosmosdb_account_name" {
  description = "Name of the CosmosDB account"
  default     = "talha-resume-cosmosdb"
}

variable "function_app_name" {
  description = "Name of the Function App"
  default     = "talha-resume-func-2025"
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  default     = "talharesumestorage"
}

variable "cdn_profile_name" {
  description = "Name of the CDN Profile"
  default     = "talha-resume-cdn"
}

variable "domain_name" {
  description = "Custom domain name"
  default     = "talharesume.com"
}