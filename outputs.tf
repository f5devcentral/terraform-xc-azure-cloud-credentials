output "azure_subscription_id" {
  value       = var.create_sa ? replace(data.azurerm_subscription.primary.id, "//subscriptions//", "")  : var.azure_subscription_id
  sensitive   = true
  description = "Azure Subscription ID"
}

output "azure_tenant_id" {
  value       = var.create_sa ? data.azuread_client_config.current.tenant_id : var.azure_tenant_id
  sensitive   = true
  description = "Azure Tenant ID"
}

output "azure_client_id" {
  value       = var.create_sa ? azuread_application.this[0].client_id : null
  sensitive   = true
  description = "Created Azure Service Principal Application ID"
}

output "azure_client_secret" {
  value       = var.create_sa ? azuread_service_principal_password.this[0].value : null
  sensitive   = true
  description = "Created Azure Service Principal Password"
}

output "azure_role_definition_resource_id" {
  value       = var.create_sa ? azurerm_role_definition.this[0].role_definition_resource_id : null
  sensitive   = true
  description = "Created Azure Role Definition Resource ID"
}

output "azure_service_principal_id" {
  value       = var.create_sa ? azuread_service_principal.this[0].id : null
  sensitive   = true
  description = "Created Azure Service Principal ID"
}

output "name" {
  value       = volterra_cloud_credentials.this.name
  description = "Created XC Cloud Credentials name"
}

output "namespace" {
  value       = volterra_cloud_credentials.this.namespace
  description = "The namespace in which the XC Cloud Credentials is created"
}

output "id" {
  value       = volterra_cloud_credentials.this.id
  description = "ID of the created XC Cloud Credentials"
}
