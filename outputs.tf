output "azure_subscription_id" {
  value       = local.create_sa ? replace(data.azurerm_subscription.primary.id, "//subscriptions//", "")  : var.azure_subscription_id
  description = "Azure Subscription ID"
}

output "azure_tenant_id" {
  value       = local.create_sa ? data.azuread_client_config.current.tenant_id : var.azure_tenant_id
  description = "Azure Tenant ID"
}

output "azure_client_id" {
  value       = local.create_sa ? azuread_application.this[0].client_id : var.azure_client_id
  description = "Azure Service Principal Application ID"
}

output "azure_client_secret" {
  value       = local.create_sa ? azuread_service_principal_password.this[0].value : var.azure_client_secret
  sensitive   = true
  description = "Azure Service Principal Password"
}

output "azure_role_definition_resource_id" {
  value       = local.create_sa ? azurerm_role_definition.this[0].role_definition_resource_id : null
  description = "Azure Service Principal Password"
}

output "azure_service_principal_id" {
  value       = local.create_sa ? azuread_service_principal.this[0].id : null
  description = "Azure Service Principal ID"
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
