output "azure_subscription_id" {
  sensitive   = true
  value       = module.azure_cloud_credentials.azure_subscription_id
  description = "Azure Subscription ID"
}

output "azure_tenant_id" {
  value       = module.azure_cloud_credentials.azure_tenant_id
  sensitive   = true
  description = "Azure Tenant ID"
}

output "azure_client_id" {
  value       = module.azure_cloud_credentials.azure_client_id
  sensitive   = true
  description = "Azure Service Principal Application ID"
}

output "azure_client_secret" {
  value       = module.azure_cloud_credentials.azure_client_secret
  sensitive   = true
  description = "Azure Service Principal Password"
}

output "azure_role_definition_resource_id" {
  sensitive   = true
  value       = module.azure_cloud_credentials.azure_role_definition_resource_id
  description = "Azure Role Definition Resource ID"
}

output "azure_service_principal_id" {
  value       = module.azure_cloud_credentials.azure_service_principal_id
  sensitive   = true
  description = "Azure Service Principal ID"
}

output "name" {
  value       = module.azure_cloud_credentials.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = module.azure_cloud_credentials.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = module.azure_cloud_credentials.id
  description = "ID of the created XC Cloud Credentials"
}
