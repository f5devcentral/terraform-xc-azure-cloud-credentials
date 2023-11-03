variable "xc_api_url" {
  description = "F5 XC Cloud API URL"
  type        = string
  default     = "https://your_xc-cloud_api_url.console.ves.volterra.io/api"
}

variable "xc_api_p12_file" {
  description = "Path to F5 XC Cloud API certificate"
  type        = string
  default     = "./api-certificate.p12"
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