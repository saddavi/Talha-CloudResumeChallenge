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
  description = "Primary Azure region for resources"
  type        = string
  default     = "qatarcentral"  # Updated to match existing resources
}

variable "function_location" {
  description = "Azure region for function app"
  type        = string
  default     = "UAE North"  # Separate variable for function app location
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {}  # No common tags in the output
}

variable "allowed_origins" {
  description = "Allowed origins for CORS"
  type        = list(string)
  default     = ["https://talharesume.com", "https://www.talharesume.com"]
}