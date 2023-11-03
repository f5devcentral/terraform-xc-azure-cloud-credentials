output "azure_subscription_id" {
  value       = module.azure_creds.azure_subscription_id
  description = "Azure Subscription ID"
}

output "azure_tenant_id" {
  value       = module.azure_creds.azure_tenant_id
  description = "Azure Tenant ID"
}

output "azure_client_id" {
  value       = module.azure_creds.azure_client_id
  description = "Azure Service Principal Application ID"
}

output "azure_client_secret" {
  value       = module.azure_creds.azure_client_secret
  sensitive   = true
  description = "Azure Service Principal Password"
}

output "azure_role_definition_resource_id" {
  value       = module.azure_creds.azure_role_definition_resource_id
  description = "Azure Service Principal Password"
}

output "azure_service_principal_id" {
  value       = module.azure_creds.azure_service_principal_id
  description = "Azure Service Principal ID"
}

output "name" {
  value       = module.azure_creds.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = module.azure_creds.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = module.azure_creds.id
  description = "ID of the created XC Cloud Credentials"
}
