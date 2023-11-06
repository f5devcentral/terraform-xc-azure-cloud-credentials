variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Cloud Credentials name"
  type        = string
  default     = ""
}

variable "azure_subscription_id" {
  description = "Existing Azure Subscription ID"
  type        = string
  default     = null
}

variable "azure_tenant_id" {
  description = "Existing Azure Tenant ID"
  type        = string
  default     = null
}

variable "azure_client_secret" {
  description = "Existing Azure Service Principal Password"
  type        = string
  sensitive   = true
  default     = null
}

variable "azure_client_id" {
  description = "Existing Azure Service Principal Application ID"
  type        = string
  default     = null
}

variable "end_date_relative" {
  description = "A relative duration for which the password is valid until, for example 240h (10 days) or 2400h30m. Changing this field forces a new resource to be created."
  type        = string
  sensitive   = true
  default     = "8766h"
}

variable "end_date" {
  description = " The end date until which the password is valid, formatted as an RFC3339 date string (e.g. 2018-01-01T01:02:03Z). Changing this field forces a new resource to be created."
  type        = string
  sensitive   = true
  default     = null
}