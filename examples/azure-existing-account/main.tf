provider "volterra" {
  api_p12_file = var.xc_api_p12_file
  url          = var.xc_api_url
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"

  subscription_id   = var.azure_subscription_id
  tenant_id         = var.azure_tenant_id
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}

module "azure_cloud_credentials" {
  source                = "../.."

  name                  = "azure-tf-demo-creds"
  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id       = var.azure_tenant_id
  azure_client_id       = var.azure_client_id
  azure_client_secret   = var.azure_client_secret
}
