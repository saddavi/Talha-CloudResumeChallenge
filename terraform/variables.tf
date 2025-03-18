# variables.tf - A separate file for variable definitions

variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "talha"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-cloudresume"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "UAE North"  # Based on your README
}

variable "backup_location" {
  description = "Backup Azure region for resources"
  type        = string
  default     = "Qatar Central"  # Based on your README
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "CloudResumeChallenge"
    Owner       = "Talha"
  }
}

variable "allowed_origins" {
  description = "Allowed origins for CORS"
  type        = list(string)
  default     = ["https://www.talharesume.com"]
}
